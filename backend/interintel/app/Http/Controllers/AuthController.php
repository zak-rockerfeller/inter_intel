<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class AuthController extends Controller{

    //Register user
     public function register(Request $request){

        //Validate fields
        $attrs = $request->validate([
            'name' => 'required|string',
            'email' => 'required|email|unique:users,email',
            'phone' => 'required|string']);


        //Create user
        $user = User::create([
            'name' => $attrs['name'],
            'email' => $attrs['email'],
            'phone' => $attrs['phone'],


        ]);

        //return user and token
        return response([
            'user' => $user,
            'token' => $user->createToken('secret')->plainTextToken], 200);
     }

         public function index(){
        return response([
            'cards' => User::orderBy('created_at', 'desc')->get()], 200);
    }

}