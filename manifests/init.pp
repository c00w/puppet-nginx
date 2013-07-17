class nginx {
    package {"nginx":
        ensure  => latest
    }

    file {"/etc/nginx/sites-available/observatory":
        ensure  => present,
        source  => "puppet:///modules/nginx/observatory",
    }

    file {"/etc/nginx/sites-enabled/observatory":
        ensure  => link,
        target  => "/etc/nginx/sites-available/observatory",
    }

    file {"/etc/nginx/sites-enabled/default":
        ensure  => absent,
    }

    service {"nginx":
        ensure  => running,
        enable  => true,
        require => [
            Package["nginx"],
        ],
        subscribe => [
            File["/etc/nginx/sites-available/observatory"],
            File["/etc/nginx/sites-enabled/observatory"],
        ],
    }
}
