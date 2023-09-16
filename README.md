# Access Laravel Passport API from Shell Script using CURL and JQ

Refer detailed article on https://dwij.net/how-to-access-laravel-passport-api-from-shell-script-using-curl-and-jq/

Laravel Project Setup:

```
composer create-project laravel/laravel laravel-passport-api-shell-curl-access
```

Open project in VSCode and confugure `.env` for Database.

### Passport Setup:

Reference: https://laravel.com/docs/10.x/passport

```
composer require laravel/passport

php artisan vendor:publish --tag=passport-migrations

php artisan migrate
```

### Install Passport:
```
php artisan passport:install

Encryption keys generated successfully.
Personal access client created successfully.
Client ID: 1
Client secret: n1YlkwsK2HzSWNKslCMiROQE6JwphThzKLop8NPL
Password grant client created successfully.
Client ID: 2
Client secret: 0CCAM6C1lmzRA2thAOMTnRJXTLzNyguOdIDhCmIn
```

Copy the credentials somewhere.

Open `config/auth.php` and setup api authentication.

```
'guards' => [
    'web' => [
        'driver' => 'session',
        'provider' => 'users',
    ],
 
    'api' => [
        'driver' => 'passport',
        'provider' => 'users',
    ],
],
```

Create Password Grant Client

```
php artisan passport:client --password

 What should we name the password grant client? [Laravel Password Grant Client]:
 > USER_AUTH   

 Which user provider should this client use to retrieve users? [users]:
  [0] users
 > 0

Password grant client created successfully.
Client ID: 3
Client secret: AU43oYLwMrBVMuaxxhG636yMqsJytSaYVrIcikjU
```

Now create a User in Laravel Tinker:

```
php artisan tinker

$user = new App\Models\User;
$user->name = 'John Doe';
$user->email = 'john@example.com';
$user->password = bcrypt('secret');
$user->save();
```

Enable API Authentication using Passport (`auth:api`) in `routes/api.php`

```
Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});
```
