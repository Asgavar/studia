<?php

namespace RESTfulProducts\StorageManagers;

use Gaufrette\Filesystem;
use Gaufrette\Adapter\Local as LocalAdapter;
use Money\Money;

use RESTfulProducts\DataSpecifications\ProductCollection;
use RESTfulProducts\DataSpecifications\ProductIndividual;


class FSProductStorageManager implements ProductStorageManagerInterface
{
    private $INDEX_FILE_NAME = ".indexcounter";
    private $PRODUCT_FILE_PREFIX = "product_";

    private $adapter;
    private $filesystem;


    public function __construct(string $workingDirectory)
    {
        $this->adapter = new LocalAdapter($workingDirectory);
        $this->filesystem = new Filesystem($this->adapter);
    }


    public function writeProduct(ProductIndividual $product): void
    {
        $currentCount = $this->getProductsCount();
        $currentCount++;
        $product->setId($currentCount);

        $this->filesystem->write(
            $this->PRODUCT_FILE_PREFIX . $currentCount,
            serialize($product),
            true
        );

        $this->filesystem->write(
            $this->INDEX_FILE_NAME,
            $currentCount,
            true
        );
    }


    public function loadProduct(int $productId): ProductIndividual
    {
        // rzucic wyjatek lub zwrocic produkt
        try
        {
            $productFile = $this->filesystem->get(
                $this->PRODUCT_FILE_PREFIX . $productId
            );

            return unserialize(
                $productFile->getContent()
            );
        }

        catch (\Exception $e)
        {
            return new ProductIndividual(
                $productId,
                "Produkt został usunięty lub nigdy nie istniał",
                Money::PLN(0)
            );
        }
    }


    /**
     * Sprawdzamy, jaki jest najwyzszy przydzielony do tej pory indeks i
     * probujemy odczytac wszystkie produkty z id mniejszym od niego.
     */
    public function loadAllProducts(): ProductCollection
    {
        $currentCount = $this->getProductsCount();
        $allProducts = new ProductCollection();

        for ($x = 0; $x < $currentCount; $x++)
        {
            $allProducts->addProduct(
                $this->loadProduct($x)
            );
        }

        return $allProducts;
    }


    public function deleteProduct(int $productId): void
    {
        $this->filesystem->delete(
            $this->PRODUCT_FILE_PREFIX . (string)$productId
        );
    }


    public function insertProduct(int $productId, ProductIndividual $product): void
    {
        $this->filesystem->write(
            $this->PRODUCT_FILE_PREFIX . $productId,
            serialize($product),
            true
        );
    }


    public function getProductsCount(): int
    {
        try
        {
            $count = $this->filesystem
                ->get($this->INDEX_FILE_NAME)
                ->getContent();
        }

        // jesli to pierwszy zapisywany produkt
        catch (\Exception $e)
        {
            $count = 0;
        }

        return $count;
    }
}
