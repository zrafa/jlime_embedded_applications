Summary: GNU Dict - mydict client
Name: mydict-plugins
Version: 0.6.0
Release: 1
Copyright: GPL
Group: Applications/Productivity
Source: %{name}-%{version}.tar.gz
Provides: mydict
Packager: Larry Cai <caiyu@yahoo.com>

%description
mydict-plugins is plugins for GTK+ based dictionary client.

see http://sourceforge.net/projects/gnudict for more.

%prep
%setup -q
%build
./configure --bindir=/usr/local/share/mydict/plugins
make
%install
make install
%files
%defattr(-,root,root)
/usr/local/share/mydict/plugins/plugndict.so
/usr/local/share/mydict/plugins/plugndict.ini
/usr/local/share/mydict/plugins/babylon.so
/usr/local/share/mydict/plugins/babylon.ini
/usr/local/share/mydict/plugins/rfc2229.so
/usr/local/share/mydict/plugins/rfc2229.ini


