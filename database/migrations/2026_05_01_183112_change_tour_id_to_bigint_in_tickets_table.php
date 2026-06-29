<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

class ChangeTourIdToBigintInTicketsTable extends Migration
{
    public function up()
    {
        // Найти и удалить внешний ключ, если он существует
        $foreignKeyName = 'tickets_tour_id_foreign'; // стандартное имя, которое даёт Laravel
        $exists = DB::select("
            SELECT 1 FROM pg_constraint 
            WHERE conname = ? AND conrelid = 'tickets'::regclass
        ", [$foreignKeyName]);

        if ($exists) {
            Schema::table('tickets', function (Blueprint $table) use ($foreignKeyName) {
                $table->dropForeign($foreignKeyName);
            });
        } else {
            // Попробуем найти динамически созданное имя
            $fk = DB::select("
                SELECT conname 
                FROM pg_constraint 
                WHERE conrelid = 'tickets'::regclass 
                  AND confrelid = 'tours'::regclass
            ");
            if (!empty($fk)) {
                $dynamicName = $fk[0]->conname;
                Schema::table('tickets', function (Blueprint $table) use ($dynamicName) {
                    $table->dropForeign($dynamicName);
                });
            }
        }

        // Изменяем тип столбца
        DB::statement('ALTER TABLE tickets ALTER COLUMN tour_id TYPE BIGINT USING (tour_id::bigint)');

        // Восстанавливаем внешний ключ
        Schema::table('tickets', function (Blueprint $table) {
            $table->foreign('tour_id')->references('id')->on('tours')->onDelete('cascade');
        });
    }

    public function down()
    {
        // Удаляем внешний ключ
        Schema::table('tickets', function (Blueprint $table) {
            $table->dropForeign(['tour_id']);
        });

        // Меняем тип обратно на VARCHAR
        DB::statement('ALTER TABLE tickets ALTER COLUMN tour_id TYPE VARCHAR(255) USING (tour_id::varchar)');
    }
}