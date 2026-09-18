import csv
import datetime
import os
import time
import sys

import psutil


def get_core_temps():
    """
    获取温度
    :return:
        - on success, return sensors, [(label, temps), ...]
        - 当失败时, return None, []
    """
    temps = psutil.sensors_temperatures()
    if not temps:
        return None, []

    for name in ("coretemp", "k10temp", "cpu_thermal", "acpitz"):
        if name in temps:
            entries = [(e.label or "unknown", e.current) for e in temps[name]]
            return name, entries

    name = next(iter(temps))
    entries = [(e.label or "unknown", e.current) for e in temps[name]]
    return name, entries


def sort_key(s):
    vec = s.split()
    name = vec[0]
    id = vec[-1].strip()

    priority = 0
    if name == "Package":
        priority = 0
    else:
        priority = 1
    return (priority, int(id))


class CpuTempWriter:
    def __init__(self, output_path):
        self._f = None
        self._writer = None

        # field names
        self._fieldnames = ["datetime"]
        sensor_name, temps = get_core_temps()
        if sensor_name is None:
            print("failed read core temps")
            return

        labels = []
        if sensor_name is not None:
            for label, _ in temps:
                labels.append(label)
            labels.sort(key=sort_key)
        self._fieldnames.extend(labels)

        # open file
        if os.path.exists(output_path):
            self._f = open(output_path, "a", encoding="utf-8")
            self._writer = csv.DictWriter(self._f, fieldnames=self._fieldnames)
        else:
            self._f = open(output_path, "w", encoding="utf-8")
            self._writer = csv.DictWriter(self._f, fieldnames=self._fieldnames)
            self._writer.writeheader()
            self._f.flush()

    def dump(self, dt):
        if self._f is None:
            return

        sensor_name, temps = get_core_temps()
        if sensor_name is not None:
            data = {}
            data["datetime"] = dt
            for label, temps in temps:
                data[label] = temps
            self._writer.writerow(data)
            self._f.flush()


class CpuPercentWriter:
    def __init__(self, output_path):
        self._f = None
        self._writer = None

        # field names
        self._fieldnames = ["datetime"]
        percents = psutil.cpu_percent(percpu=True)
        if not percents:
            print("failed read percents")
            return

        labels = []
        for i, _ in enumerate(percents):
            labels.append("Core {}".format(i))
            labels.sort(key=sort_key)
        self._fieldnames.extend(labels)

        # open file
        if os.path.exists(output_path):
            self._f = open(output_path, "a", encoding="utf-8")
            self._writer = csv.DictWriter(self._f, fieldnames=self._fieldnames)
        else:
            self._f = open(output_path, "w", encoding="utf-8")
            self._writer = csv.DictWriter(self._f, fieldnames=self._fieldnames)
            self._writer.writeheader()
            self._f.flush()

    def dump(self, dt):
        if self._f is None:
            return

        percents = psutil.cpu_percent(percpu=True)
        row = {}
        row["datetime"] = dt
        for i, p in enumerate(percents):
            row["Core {}".format(i)] = p
        self._writer.writerow(row)
        self._f.flush()


class CpuFreqWriter:
    def __init__(self, output_cur_path, output_min_path, output_max_path):
        self._f_cur = None
        self._writer_cur = None
        self._f_min = None
        self._writer_min = None
        self._f_max = None
        self._writer_max = None

        # field names
        self._fieldnames = ["datetime"]
        freqs = psutil.cpu_freq(percpu=True)
        if not freqs:
            print("failed read freqs")
            return

        labels = []
        for i, _ in enumerate(freqs):
            labels.append("Core {}".format(i))
            labels.sort(key=sort_key)
        self._fieldnames.extend(labels)

        # open file
        if os.path.exists(output_cur_path):
            self._f_cur = open(output_cur_path, "a", encoding="utf-8")
            self._writer_cur = csv.DictWriter(self._f_cur, fieldnames=self._fieldnames)
        else:
            self._f_cur = open(output_cur_path, "w", encoding="utf-8")
            self._writer_cur = csv.DictWriter(self._f_cur, fieldnames=self._fieldnames)
            self._writer_cur.writeheader()
            self._f_cur.flush()

        if os.path.exists(output_min_path):
            self._f_min = open(output_min_path, "a", encoding="utf-8")
            self._writer_min = csv.DictWriter(self._f_min, fieldnames=self._fieldnames)
        else:
            self._f_min = open(output_min_path, "w", encoding="utf-8")
            self._writer_min = csv.DictWriter(self._f_min, fieldnames=self._fieldnames)
            self._writer_min.writeheader()
            self._f_min.flush()

        if os.path.exists(output_max_path):
            self._f_max = open(output_max_path, "a", encoding="utf-8")
            self._writer_max = csv.DictWriter(self._f_max, fieldnames=self._fieldnames)
        else:
            self._f_max = open(output_max_path, "w", encoding="utf-8")
            self._writer_max = csv.DictWriter(self._f_max, fieldnames=self._fieldnames)
            self._writer_max.writeheader()
            self._f_max.flush()

    def dump(self, dt):
        if self._f_cur is None:
            return

        freqs = psutil.cpu_freq(percpu=True)
        row = {}
        row["datetime"] = dt
        for i, f in enumerate(freqs):
            row["Core {}".format(i)] = f.current
        self._writer_cur.writerow(row)
        self._f_cur.flush()

        for i, f in enumerate(freqs):
            row["Core {}".format(i)] = f.min
        self._writer_min.writerow(row)
        self._f_min.flush()

        for i, f in enumerate(freqs):
            row["Core {}".format(i)] = f.max
        self._writer_max.writerow(row)
        self._f_max.flush()


class MemPercentWriter:
    def __init__(self, output_path):
        self._f = None
        self._writer = None

        # field names
        self._fieldnames = ["datetime", "memory"]
        mem = psutil.virtual_memory()
        if not mem:
            print("failed read virtual memory")
            return

        # open file
        if os.path.exists(output_path):
            self._f = open(output_path, "a", encoding="utf-8")
            self._writer = csv.DictWriter(self._f, fieldnames=self._fieldnames)
        else:
            self._f = open(output_path, "w", encoding="utf-8")
            self._writer = csv.DictWriter(self._f, fieldnames=self._fieldnames)
            self._writer.writeheader()
            self._f.flush()

    def dump(self, dt):
        if self._f is None:
            return

        mem = psutil.virtual_memory()
        row = {}
        row["datetime"] = dt
        row["memory"] = mem.percent
        self._writer.writerow(row)
        self._f.flush()


if __name__ == "__main__":
    if len(sys.argv) < 2:
        interval = 30
    else:
        interval = int(sys.argv[1])

    # prepare csv writer
    output_dir = "build"
    if not os.path.exists(output_dir):
        os.makedirs(output_dir, exist_ok=True)

    writer_temp = CpuTempWriter(os.path.join(output_dir, "temps.csv"))
    writer_percent = CpuPercentWriter(os.path.join(output_dir, "percents.csv"))
    writer_freq = CpuFreqWriter(os.path.join(output_dir, "freqs_cur.csv"),
                                os.path.join(output_dir, "freqs_min.csv"),
                                os.path.join(output_dir, "freqs_max.csv"))
    writer_mem = MemPercentWriter(os.path.join(output_dir, "mem.csv"))

    while True:
        time.sleep(interval)
        dt = datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%S")

        writer_temp.dump(dt)
        writer_percent.dump(dt)
        writer_freq.dump(dt)
        writer_mem.dump(dt)
