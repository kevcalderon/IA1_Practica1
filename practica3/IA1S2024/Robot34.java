package IA1S2024;

import robocode.*;
import robocode.util.Utils;
import java.awt.Color;

public class Robot34 extends AdvancedRobot {
    double energiaPrevia = 100;
    int direccionMovimiento = 1;
    int direccionGun = 1;

    public void run() {
        // Establecer colores
        setColors(Color.red, Color.black, Color.green);

        // Bucle principal del robot. Mantiene el cañón girando para buscar enemigos
        // constantemente.
        while (true) {
            turnGunRight(360 * direccionGun);
        }
    }

    public void onScannedRobot(ScannedRobotEvent evento) {
        // Cambiar la dirección de movimiento si el robot escaneado ha disparado una
        // bala
        double cambioEnergia = energiaPrevia - evento.getEnergy();
        if (cambioEnergia > 0 && cambioEnergia <= 3) {
            // Si el enemigo ha disparado, cambia la dirección de movimiento para esquivar
            // el ataque.
            direccionMovimiento = -direccionMovimiento;
            ahead((evento.getDistance() / 4 + 25) * direccionMovimiento);
        }
        energiaPrevia = evento.getEnergy();

        double giroC = Utils.normalRelativeAngleDegrees(evento.getBearing() + getHeading() - getGunHeading());
        turnGunRight(giroC);
        fire(1); // Siempre disparar con potencia 1

        direccionGun = -direccionGun;
    }

    public void onHitByBullet(HitByBulletEvent e) {
        // Si te golpea una bala, revertir la dirección y mover hacia atrás
        back(50 * direccionMovimiento);
    }

    public void onHitWall(HitWallEvent e) {
        // Si choca con una pared, revertir la dirección
        direccionMovimiento = -direccionMovimiento;
        ahead(100 * direccionMovimiento);
    }
}
