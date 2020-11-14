import argparse
import ctypes
from pathlib import Path
import os
import logging

log_file = Path(__file__).parent / "load_dll.log"
logging.basicConfig(
    format="%(levelname)s - %(message)s", filename=str(log_file), level=logging.DEBUG
)
parser = argparse.ArgumentParser()
parser.add_argument(
    "dll_location", help="The folder which contains the dll files to load."
)
args = parser.parse_args()

dll_location = Path(args.dll_location)

logging.debug(f"Adding {dll_location.absolute()} to PATH varible.")
os.environ["PATH"] = f"{dll_location.absolute()}{os.pathsep}{os.environ['PATH']}"

# necessary_files = ["libglib-2.0-0.dll","libcairo-2.dll","zlib1.dll","libffi-7.dll"]
# cairo deps here
necessary_files = [
    "ZLIB1.DLL",  #
    "LIBPNG16-16.DLL",  #
    "LIBPIXMAN-1-0.DLL",  #
    "LIBWINPTHREAD-1.DLL",
    "LIBGCC_S_SEH-1.DLL",  #
    "LIBSSP-0.DLL",  #
    "LIBINTL-8.DLL",
    "LIBICONV-2.DLL",
    "LIBEXPAT-1.DLL",
    "LIBFONTCONFIG-1.DLL",  #
    "LIBBROTLICOMMON.DLL",
    "LIBBROTLIDEC.DLL",
    "LIBBZ2-1.DLL",
    "LIBSTDC++-6.DLL",
    "LIBGRAPHITE2.DLL",
    "LIBHARFBUZZ-0.DLL",
    "LIBPCRE-1.DLL",
    "LIBGLIB-2.0-0.DLL",
    "LIBFREETYPE-6.DLL",
    "LIBCAIRO-2.DLL",
]
# for libpango-1
necessary_files += [
    "LIBFRIBIDI-0.DLL",
    "LIBGMODULE-2.0-0.DLL",
    "LIBGIO-2.0-0.DLL",
    "LIBGLIB-2.0-0.DLL",
    "LIBFFI-7.DLL",
    "LIBGOBJECT-2.0-0.DLL",
    "LIBDATRIE-1.DLL",
    "LIBTHAI-0.DLL",
]
# for libpangocairo-1
necessary_files += [
    "LIBPANGOFT2-1.0-0.DLL",
    "LIBPANGOWIN32-1.0-0.DLL",
]
for file in necessary_files:
    fp = str((dll_location / file).absolute())
    logging.debug(f"Loading {fp}")
    try:
        ctypes.CDLL(fp)
    except OSError:
        logging.error(f"OSError for {fp}")
for file in dll_location.glob("libpango*.dll"):
    logging.debug(f"Loading {file}")
    try:
        ctypes.CDLL(str(file.absolute()))
    except OSError:
        logging.error(f"OSError for {file}")
