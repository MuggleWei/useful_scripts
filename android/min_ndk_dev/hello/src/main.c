#include <stdio.h>
#include <time.h>

int main() {
  time_t ts = time(NULL);
  struct tm t;

  fprintf(stdout, "hello world\n");

  localtime_r(&ts, &t);
  fprintf(stdout, "current datetime: %d-%02d-%2dT%02d:%02d:%02d\n",
          t.tm_year + 1900, t.tm_mon + 1, t.tm_mday, t.tm_hour, t.tm_min,
          t.tm_sec);

  return 0;
}
