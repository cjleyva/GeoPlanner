<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAlertasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('alertas', function (Blueprint $table) {
            $table->id();
            $table->unsignedInteger('id_remitente')->default(0)->comment('identificador del usuario que envia el mensaje');
            $table->unsignedInteger('id_destinatario')->default(0)->comment('identificador del id usuario que recibe el mensaje');
            $table->string('origen', 255)->comment('modulo o pantalla de origen que esta enviando la alerta');
            $table->string('destino', 500)->comment('link de destino al cual direccion el sistema al hacer clic en enviar');
            $table->string('titulo', 250)->comment('título del mensaje');
            $table->text('mensaje')->comment('cuerpo del mesaje');
            $table->unsignedInteger('es_alerta')->default(0)->comment('cuando es una alerta a pantalla');
            $table->unsignedInteger('es_mail')->default(0)->comment('Cuando es un mensaje a correo electronico');
            $table->unsignedInteger('email_enviado')->default(0)->comment('Cuando se envia el correo se actualiza este campo');
            $table->unsignedInteger('estado')->default(1)->comment('si es 1 es creado, si es 2 es marcadado como leido, si es 0 es eliminado');
            $table->unsignedInteger('created_by')->default(0)->comment('usuario que crea el registro');
            $table->unsignedInteger('updated_by')->default(0)->comment('usuario que actualiza el registro');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('alertas');
    }
}
