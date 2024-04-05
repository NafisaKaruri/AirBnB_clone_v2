# sets up your web servers for the deployment of web_static

exec { 'apt-get-update':
  command => '/usr/bin/env apt-get -y update',
}

exec { 'apt-get-upgrade':
  command => '/usr/bin/env apt-get -y upgrade',
}

package { 'nginx':
  ensure   => 'installed',
}

exec {'test folder':
  command => '/usr/bin/env mkdir -p /data/web_static/releases/test/',
}

exec {'shared folder':
  command => '/usr/bin/env mkdir -p /data/web_static/shared/',
}

exec {'index html':
  command => '/usr/bin/env echo "Welcome to AirBnB" > /data/web_static/releases/test/index.html',
}

exec {'ln -s':
  command => '/usr/bin/env ln -sf /data/web_static/releases/test /data/web_static/current',
}

exec {'nginx conf':
  command => '/usr/bin/env sed -i "/listen 80 default_server/a location /hbnb_static/ { alias /data/web_static/current/;}" /etc/nginx/sites-available/default',
}

exec {'chown:':
  command => '/usr/bin/env chown -R ubuntu:ubuntu /data',
}

exec {'service':
  command => '/usr/bin/env service nginx restart',
}
