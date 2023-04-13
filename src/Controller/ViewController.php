<?php

namespace App\Controller;

use App\Entity\Genre;
use App\Entity\Serie;
use App\Entity\Episode;
use App\Form\AddGenreType;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

class ViewController extends AbstractController
{
    #[Route('/library', name: 'app_genres')]
    public function renderGenresPage(EntityManagerInterface $entityManager): Response
    {
        $genres = $entityManager->getRepository(Genre::class)->findAll();

        if (!$genres) {
            throw $this->createNotFoundException(
                'No genre found for id '
            );
        }

        return $this->render('public/index.html.twig', [
            'controller_name' => 'genresController',
            'genres' => $genres,
        ]);
    }

    #[Route('/library/{a}', name: 'app_genre')]
    public function renderGenrePage(EntityManagerInterface $entityManager, int $a): Response
    {
        $genre = $entityManager->getRepository(Genre::class)->find($a);
        $series = $entityManager->getRepository(Serie::class)->findBy(
            ['relation' => $a]
        );

        if (!$genre) {
            throw $this->createNotFoundException(
                'No genre found for id '.$a
            );
        }

        if (!$series) {
            throw $this->createNotFoundException(
                'No serie found for id '.$a
            );
        }

        return $this->render('public/genre.html.twig', [
            'controller_name' => 'seriesController',
            'genre' => $genre,
            'series' => $series,
        ]);
    }

    #[Route('/library/{a}/serie/{b}', name: 'app_serie')]
    public function renderSeriePage(EntityManagerInterface $entityManager, int $a, int $b): Response
    {
        $genre = $entityManager->getRepository(Genre::class)->find($a);
        $serie = $entityManager->getRepository(Serie::class)->find($b);
        $episodes = $serie->getEpisodes(Episode::class);

        if (!$genre) {
            throw $this->createNotFoundException(
                'No genre found for id '.$a
            );
        }

        if (!$serie) {
            throw $this->createNotFoundException(
                'No serie found for id '.$b
            );
        }

        if (!$episodes) {
            throw $this->createNotFoundException(
                'No episodes found for id '.$b
            );
        }

        return $this->render('public/serie.html.twig', [
            'controller_name' => 'seriesController',
            'genre' => $genre,
            'serie' => $serie,
            'episodes' => $episodes,
        ]);
    }

    #[Route('/library/upload/genre', name: 'create_genre')]
    public function createGenre(EntityManagerInterface $entityManager, Request $request): Response
    {
        // just set up a fresh $task object (remove the example data)
        $genre = new Genre();

        $form = $this->createForm(AddGenreType::class, $genre);

        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $genre = $form->getData();
            $entityManager->persist($genre);
            $entityManager->flush();
            return $this->redirectToRoute('app_genres');
        }
        return $this->render('public/create.html.twig', [
            'form' => $form,
        ]);
    }
}
