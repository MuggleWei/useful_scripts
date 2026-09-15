import csv
import datetime
import os
import time

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


class TempWriter:
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


class PercentWriter:
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


class FreqWriter:
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

    def dump(self, dt, key=None):
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


if __name__ == "__main__":
    # prepare csv writer
    output_dir = "build"
    if not os.path.exists(output_dir):
        os.makedirs(output_dir, exist_ok=True)

    writer_temp = TempWriter(os.path.join(output_dir, "temps.csv"))
    writer_percent = PercentWriter(os.path.join(output_dir, "percents.csv"))
    writer_freq = FreqWriter(os.path.join(output_dir, "freqs_cur.csv"),
                             os.path.join(output_dir, "freqs_min.csv"),
                             os.path.join(output_dir, "freqs_max.csv"))

    while True:
        time.sleep(3)
        dt = datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%S")

        writer_temp.dump(dt)
        writer_percent.dump(dt)
        writer_freq.dump(dt, key="cur")
