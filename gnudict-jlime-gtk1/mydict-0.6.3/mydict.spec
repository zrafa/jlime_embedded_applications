Summary: GNU Dict - mydict client GTK+ version
Name: mydict
Version: 0.6.3
Release: 1
Copyright: GPL
Group: Applications/Productivity
Source: %{name}-%{version}.tar.gz
Provides: mydict
Packager: Larry Cai <caiyu@yahoo.com>

%description
mydict is GTK+ based dictionary client, it needs plugin connect to the difficult dictionary (Web Dictionary,Babylon dict, DICT dictioanry) .

see http://sourceforge.net/projects/gnudict for more.

%prep
%setup -q
%build
./configure
make
%install
make install
%files
%defattr(-,root,root)
/usr/local/bin/mydict
/usr/local/share/mydict/pixmaps/mydict.xpm
/usr/local/share/mydict/mydict.ini
/usr/local/share/mydict/ybfont/*
/usr/local/share/locale/*
