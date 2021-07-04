#!/usr/local/bin/python

import os.path
import re
import subprocess
import time
import traceback
from watchdog.events import FileSystemEventHandler, FileCreatedEvent, FileModifiedEvent
from watchdog.observers import Observer

class Path:
    def __init__(self, env_name):
        self.prev_time = self.time = 0
        self.prev_path = self.path = self.site = ''
        self.valid = False
        self.sites = os.environ[env_name].split()

    def set_from_watchdog(self, event):
        m = re.match(r'(/.*?/(.*?)/.*)', event.src_path)
        if m:
            self.prev_time, self.time = self.time, time.time()
            self.prev_path, self.path = self.path, m.group(1)
            self.site = m.group(2)
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

class ChangeHandler(FileSystemEventHandler):
    def on_created(self, event):
        if type(event) is FileCreatedEvent:
            self.run_oj(event)

    def on_modified(self, event):
        if type(event) is FileModifiedEvent:
            self.run_oj(event)

    def run_oj(self, event):
        try:
            path.set_from_watchdog(event)
            if not path.valid or not path.changed(): return

            print('====================', path.path)

            url.set_from_file(path.path)
            if not url.valid: return

            if url.changed():
                subprocess.run(['./oj-download', url.url], check=True)

            env['SITE'] = path.site.upper()

            root, ext = os.path.splitext(path.path)
            if ext == '.d':
                subprocess.run(['./oj-test-dmd', path.path], env=env, check=True)
            elif ext == '.nim':
                subprocess.run(['./oj-test-nim', path.path], env=env, check=True)
            elif ext == '.cr':
                subprocess.run(['./oj-test-crystal', path.path], env=env, check=True)

        except subprocess.CalledProcessError:
            pass

event_handler = ChangeHandler()
observer = Observer()
observer.schedule(event_handler, '/codes-d', recursive=True)
observer.schedule(event_handler, '/codes-crystal', recursive=True)
observer.schedule(event_handler, '/codes-nim', recursive=True)
observer.start()

try:
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    observer.stop()

observer.join()
