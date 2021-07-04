################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="xpi_gamecon"
PKG_VERSION="15c332a"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/duduke/xpi_gamecon-1.0"
PKG_URL="https://github.com/duduke/xpi_gamecon-1.0/archive/refs/heads/main.zip"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="xpi_gamecon driver for PiBoyDMG"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="manual"

make_target() {
kernel_make -C $(kernel_path) M=$PKG_BUILD modules
}

makeinstall_target() {
mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
cp $PKG_BUILD/*.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME
}
