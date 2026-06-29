<?php

namespace App\Http\Controllers;

use App\Models\Ticket;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\ValidationException;

class TicketController extends Controller
{
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name'     => 'required|string|max:255',
            'tour_id'  => 'required|integer|exists:tours,id',
        ]);

        // Принудительно приводим к строке (на всякий случай)
        $customerName = (string) $validated['name'];
        
        // Если имя пустое после приведения – ошибка
        if (empty($customerName)) {
            throw ValidationException::withMessages([
                'name' => 'Имя не может быть пустым',
            ]);
        }

        Ticket::create([
            'user_id'       => Auth::id(),
            'customer_name' => $customerName,
            'tour_id'       => (int) $validated['tour_id'],
        ]);

        return redirect()->back()->with('success', 'Билет успешно куплен!');
    }
}