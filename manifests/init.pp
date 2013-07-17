class 'nginx' {
    package {"nginx":
        ensure  => latest
    }

    file {"/etc/nginx/sites-available/observatory":
        ensure  => present,
        source  => "puppet:///nginx/observatory",
    }

    file {"/etc/nginx/sites-enabled/observatory":
        ensure  => link,
        target  => "/etc/nginx/sites-available/observatory",
    }

    service {"nginx":
        ensure  => running,
        enable  => true,
        require => [
            Package["nginx"],
            File["/etc/nginx/sites-available/observatory"],
            File["/etc/nginx/sites-enabled/observatory"],
    }
}
