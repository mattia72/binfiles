#!/bin/sh
sudo chgrp -v cdrom /usr/bin/cdrdao
sudo chmod -v 4710 /usr/bin/cdrdao

sudo chgrp -v cdrom /usr/bin/X11/cdrdao
sudo chmod -v 4710 /usr/bin/X11/cdrdao

sudo chgrp -v cdrom /usr/bin/cdrecord.mmap
sudo chmod -v 4710 /usr/bin/cdrecord.mmap

sudo chgrp -v cdrom /usr/bin/X11/cdrecord.mmap
sudo chmod -v 4710 /usr/bin/X11/cdrecord.mmap

sudo chgrp -v cdrom /usr/bin/growisofs
sudo chmod -v 4710 /usr/bin/growisofs

sudo chgrp -v cdrom /usr/bin/X11/growisofs
sudo chmod 4710 /usr/bin/X11/growisofs


ls -la /usr/bin/cdrdao
ls -la /usr/bin/X11/cdrdao
ls -la /usr/bin/cdrecord.mmap
ls -la /usr/bin/X11/cdrecord.mmap
ls -la /usr/bin/growisofs
ls -la /usr/bin/X11/growisofs


