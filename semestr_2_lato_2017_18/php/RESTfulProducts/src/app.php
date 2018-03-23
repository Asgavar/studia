<?php

require_once('../vendor/autoload.php');

$app = new Silex\Application();

$app->get('/hello/{name}', function($name) use($app) {
        return 'Hello';
});

$app->run();
