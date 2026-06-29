<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ticket extends Model
{
    use HasFactory;

    // Разрешаем массовое присвоение для этих полей
    protected $fillable = [
        'user_id',
        'customer_name',
        'tour_id',
    ];
    public function user()
{
    return $this->belongsTo(User::class);
}
public function tour()
{
    return $this->belongsTo(Tour::class);
}
}