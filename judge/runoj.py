#!/usr/local/bin/python

import os.path
import re
import subprocess
import time
import traceback

class Path:
    def __init__(self, env_name):
        self.prev_time = self.time = 0
        self.prev_path = self.path = self.site = ''
        self.valid = False
        self.sites = os.environ[env_name].split()

    def set_from_inotify(self, s):
        m = re.match(r'(\d+) (/.*?/(.*?)/.*)', s)
        if m:
            self.prev_time, self.time = self.time, int(m.group(1))
            self.prev_path, self.path = self.path, m.group(2)
            self.site = m.group(3)
            self.valid = not os.path.isdir(self.path) and self.site in self.sites
            if (self.valid): self.sleep()
        else:
            self.valid = False

    def sleep(self):
        # Some editors notify several notifications during short time
        # and the notificated file may disappear in the moment.
        time.sleep(0.2)

    def changed(self):
        return self.path != self.prev_path or self.time - self.prev_time > 2


class Url:
    def __init__(self):
        self.url = self.prev_url = ''
        self.valid = False

    def set_from_file(self, path):
        with open(path, mode='r') as file:
            for line in file:
                m = re.match(r'(//|#) URL: (.*)', line)
                if m:
                    self.prev_url, self.url = self.url, m.group(2)
                    self.valid = True
                    return
            self.valid = False

    def changed(self):
        return self.url != self.prev_url


path = Path('SITES')
url = Url()
env = os.environ.copy()

while True:
    try:
        path.set_from_inotify(input())
        if not path.valid or not path.changed(): continue

        print('====================', path.path)

        url.set_from_file(path.path)
        if not url.valid: continue

        if url.changed():
            subprocess.run(['./oj-download', url.url], check=True)

        env['SITE'] = path.site.upper()

        root, ext = os.path.splitext(path.path)
        if ext == '.d':
            subprocess.run(['./dmd-compile', path.path], env=env, check=True)
            subprocess.run(['./oj-test'], env=env, check=True)
        elif ext == '.nim':
            subprocess.run(['./nim-compile', path.path], env=env, check=True)
            subprocess.run(['./oj-test'], env=env, check=True)
        elif ext == '.cr':
            subprocess.run(['./oj-test-crystal', path.path], env=env, check=True)

    except subprocess.CalledProcessError:
        pass
