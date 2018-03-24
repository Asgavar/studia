<?php

require_once('../vendor/autoload.php');

use RESTfulProducts\Controllers\ProductsDeleteController;
use RESTfulProducts\Controllers\ProductsGetCollectionController;
use RESTfulProducts\Controllers\ProductsGetIndividualController;
use RESTfulProducts\Controllers\ProductsPostController;
use RESTfulProducts\Serializers\JSONProductSerializer;
use RESTfulProducts\StorageManagers\FSProductStorageManager;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;


$app = new Silex\Application();
$app["debug"] = true;

$jsonSerializer = new JSONProductSerializer();
$fsStorageManager = new FSProductStorageManager("/tmp/restfulproducts");


$app->get("/products", new ProductsGetCollectionController(
     $jsonSerializer,
     $fsStorageManager
 ));


$app->get("/products/{id}", function($id) use($jsonSerializer, $fsStorageManager) {
        $controller = new ProductsGetIndividualController(
            $jsonSerializer,
            $fsStorageManager,
            $id
        );
        return new Response($controller(), 200);
    });


$app->post("/products", function(Request $request) use($jsonSerializer, $fsStorageManager) {
        $controller = new ProductsPostController(
            $jsonSerializer,
            $fsStorageManager,
            $request->getContent()
        );

        return new Response($controller(), 201);
    });


//$app->put("/products/{id}", function($id) use($jsonSerializer, $fsStorageManager) {
//        $controller = new Pro
//});


$app->delete("/products/{id}", function ($id) use($jsonSerializer, $fsStorageManager) {
        $controller = new ProductsDeleteController(
            $jsonSerializer,
            $fsStorageManager,
            $id
        );

        return new Response($controller(), 204);
});


$app->run();
