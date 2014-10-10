Summary: GNU Dict - mydict client
Name: mydict-ndict
Version: 0.5.2
Release: 1
Copyright: GPL
Group: Applications/Productivity
Source: %{name}-%{version}.tar.gz
Provides: mydict
Packager: Larry Cai <caiyu@yahoo.com>

%description
mydict-ndict is ndict plugin for GTK+ based dictionary client.

see http://cosoft.org.cn/projects/gnudict for more.

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
/usr/local/share/mydict/dicts/ecdict.*
/usr/local/share/mydict/dicts/new_ecdict.*
/usr/local/share/mydict/dicts/generateIndex.pl
