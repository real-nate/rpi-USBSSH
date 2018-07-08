#|| @license
#|| | This program is free software; you can redistribute it and/or
#|| | modify it under the terms of the GNU Lesser General Public
#|| | License as published by the Free Software Foundation; version
#|| | 2.1 of the License.
#|| |
#|| | This program is distributed in the hope that it will be useful,
#|| | but WITHOUT ANY WARRANTY; without even the implied warranty of
#|| | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#|| | Lesser General Public License for more details.
#|| |
#|| | You should have received a copy of the GNU Lesser General Public
#|| | License along with this library; if not, write to the Free Software
#|| | Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#|| #

# This assumes the SD card is mounted under /Volumes/boot

cd /Volumes/boot

# To see if the ssh file is created
if [ ! -f ssh ]; then
  touch ssh
fi

# To see if the line needs to be appended
dt=$(cat config.txt | grep "dtoverlay=dwc2")
if [ "$dt" != "dtoverlay=dwc2" ]; then
  echo "dtoverlay=dwc2" >> config.txt
fi

# To see if the line needs to be appended
mod=$(cat cmdline.txt | grep -o "modules-load=dwc2,g_ether")
if [ "$mod" != "modules-load=dwc2,g_ether" ]; then
  sed -i '' '$ s/$/ modules-load=dwc2,g_ether/' cmdline.txt
  # Only appends to end of line, not newline
fi
cd
echo ""
echo '-- Files updated and ready for SSH over USB --'
echo ""
