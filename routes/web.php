<?php

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Models\Exhibit;
use App\Models\Tour;
use App\Http\Controllers\TicketController;
use App\Models\User;
use App\Http\Controllers\Admin\DashboardController as AdminDashboardController;
use App\Http\Controllers\Admin\UserController; // ← импорт контроллера пользователей

/*
|--------------------------------------------------------------------------
| ПУБЛИЧНЫЙ САЙТ (доступен всем)
|--------------------------------------------------------------------------
*/

Route::get('/', function () {
    return Inertia::render('Home');
});

Route::get('/exhibits', function () {
    return Inertia::render('Exhibits');
});

// Список туров (экскурсий)
Route::get('/tours', function () {
    $tours = Tour::all(['id', 'title', 'description', 'price', 'duration_min']);
    return Inertia::render('Tours', ['tours' => $tours]);
});

// Страница покупки билета – доступна всем, но отправка формы требует авторизации
Route::get('/tickets', function () {
    $tours = Tour::all(['id', 'title', 'price']);
    $selectedTourId = request()->query('tour_id');
    return Inertia::render('Tickets', [
        'tours' => $tours,
        'selectedTourId' => $selectedTourId
    ]);
})->name('tickets');

/*
|--------------------------------------------------------------------------
| ДЛЯ АВТОРИЗОВАННЫХ ПОЛЬЗОВАТЕЛЕЙ
|--------------------------------------------------------------------------
*/

Route::middleware(['auth'])->group(function () {

    Route::get('/dashboard', function () {
        return Inertia::render('Dashboard');
    })->name('dashboard');

    // Обработка покупки билета
    Route::post('/tickets/buy', [TicketController::class, 'store'])->name('tickets.buy');

});

/*
|--------------------------------------------------------------------------
| АДМИН-ПАНЕЛЬ (ТОЛЬКО ADMIN)
|--------------------------------------------------------------------------
*/
Route::middleware(['auth', 'admin'])->prefix('admin')->name('admin.')->group(function () {
    Route::get('/dashboard', [AdminDashboardController::class, 'index'])->name('dashboard');
    Route::get('/users', [UserController::class, 'index'])->name('users'); // ← новый маршрут
});

/*
|--------------------------------------------------------------------------
| AUTH (Breeze)
|--------------------------------------------------------------------------
*/

require __DIR__.'/auth.php';