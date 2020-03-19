#!/bin/sh

set -ex

export HOME=/config

exec bitcoin-qt
