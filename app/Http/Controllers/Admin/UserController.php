<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function index()
{
    $users = User::withCount('tickets')->get();
    return Inertia::render('Admin/Users', ['users' => $users]);
}
}
