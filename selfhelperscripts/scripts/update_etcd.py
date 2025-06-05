#!/usr/bin/env python3
"""Update a key in etcd.

This script connects to an etcd v3 server and sets the given key to the
provided value. Authentication via username/password is optional.

Example:
    python update_etcd.py --host 127.0.0.1 --port 2379 my/key value
"""
from __future__ import annotations

import argparse

import etcd3


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Update a key in etcd")
    parser.add_argument("key", help="Key to update")
    parser.add_argument("value", help="Value to set")
    parser.add_argument("--host", default="localhost", help="etcd host")
    parser.add_argument("--port", type=int, default=2379, help="etcd port")
    parser.add_argument("--user", help="Username for authentication")
    parser.add_argument("--password", help="Password for authentication")
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    client = etcd3.client(host=args.host, port=args.port, user=args.user, password=args.password)
    client.put(args.key, args.value)
    print(f"Key '{args.key}' updated")


if __name__ == "__main__":
    main()
