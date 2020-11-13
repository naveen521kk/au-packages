import argparse
import ctypes
from pathlib import Path
import os
import logging

log_file=Path(__file__).parent / "load_dll.log"
logging.basicConfig(format="%(levelname)s - %(message)s",filename=str(log_file), level=logging.DEBUG)
parser = argparse.ArgumentParser()
parser.add_argument("dll_location",help="The folder which contains the dll files to load.")
args = parser.parse_args()

dll_location = Path(args.dll_location)

logging.debug(f"Adding {dll_location.absolute()} to PATH varible.")
os.environ["PATH"]=f"{dll_location.absolute()}{os.pathsep}{os.environ['PATH']}"

necessary_files = ["libglib-2.0-0.dll","libcairo-2.dll","zlib1.dll","libffi-7.dll"]
for file in dll_location.glob("libpango*.dll"):
    logging.debug(f"Loading {file}")
    try:
        ctypes.CDLL(str(file.absolute()))
    except OSError:
        logging.error(f"OSError for {file}")
        pass
for file in necessary_files:
    fp = str((dll_location / file).absolute())
    logging.debug(f"Loading {fp}")
    try:
        ctypes.CDLL(fp)
    except OSError:
        logging.error(f"OSError for {fp}")
        pass
