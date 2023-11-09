<?php

namespace App\Http\Middleware;

use Closure;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;



class Cors
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */


public function handle(Request $request, Closure $next): Response
{
    $response = $next($request);
    
    $response->headers->set('Access-Control-Allow-Origin', "*");
    $response->headers->set('Access-Control-Allow-Method', "GET,POST,PUT,DELETE,OPTIONS");
    $response->headers->set('Access-Control-Allow-Header', '*');
        // header('access-Control-Allow-Origin :*');
        // header('Access-Control-Allow-Methods:GET,POST');
        // header('Access-Control-Allow-Headers: *');
 
    
    return $response;
}

}
