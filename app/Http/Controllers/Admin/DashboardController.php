<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Ticket;
use App\Models\Tour;
use App\Models\User;
use Inertia\Inertia;
use Inertia\Response;

class DashboardController extends Controller
{
    public function index(): Response
    {
        // Общая статистика
        $totalUsers = User::count();
        $totalTickets = Ticket::count();
        $totalTours = Tour::count();
        $totalRevenue = Ticket::with('tour')->get()->sum(function ($ticket) {
            return $ticket->tour->price ?? 0;
        });

        // Последние 5 купленных билетов (с данными пользователя и тура)
        $recentTickets = Ticket::with(['user', 'tour'])
            ->latest()
            ->take(5)
            ->get()
            ->map(function ($ticket) {
                return [
                    'id' => $ticket->id,
                    'user_name' => $ticket->user->name ?? 'Удалён',
                    'tour_title' => $ticket->tour->title ?? 'Неизвестный тур',
                    'price' => $ticket->tour->price ?? 0,
                    'created_at' => $ticket->created_at->format('d.m.Y H:i'),
                ];
            });

        // Топ-3 популярных тура (по количеству проданных билетов)
        $popularTours = Tour::withCount('tickets')
            ->orderBy('tickets_count', 'desc')
            ->take(3)
            ->get()
            ->map(function ($tour) {
                return [
                    'id' => $tour->id,
                    'title' => $tour->title,
                    'tickets_count' => $tour->tickets_count,
                ];
            });

        return Inertia::render('Admin/Dashboard', [
            'stats' => [
                'totalUsers' => $totalUsers,
                'totalTickets' => $totalTickets,
                'totalTours' => $totalTours,
                'totalRevenue' => $totalRevenue,
            ],
            'recentTickets' => $recentTickets,
            'popularTours' => $popularTours,
        ]);
    }
}