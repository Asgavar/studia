package xyz.juraszek.airportobjectpool.tests;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import xyz.juraszek.airportobjectpool.Airport;
import xyz.juraszek.airportobjectpool.NoPlanesAvailableException;
import xyz.juraszek.airportobjectpool.Plane;
import xyz.juraszek.airportobjectpool.ThisPlaneIsNotFromHereException;

class AirportTest {

  private Airport airport;

  @AfterEach
  void tearDown() {
    this.airport = null;
  }

  @Test
  void noMoreThanSpecifiedInstancesShouldBeGiven() throws NoPlanesAvailableException {
    this.airport = new Airport(3);
    this.airport.getPlane();
    this.airport.getPlane();
    this.airport.getPlane();
    assertThrows(
        NoPlanesAvailableException.class,
        () -> this.airport.getPlane()
    );
  }

  @Test
  void allInstancesShouldBeDifferent() throws NoPlanesAvailableException {
    this.airport = new Airport(3);
    Plane first = this.airport.getPlane();
    Plane second = this.airport.getPlane();
    Plane third = this.airport.getPlane();
    assertAll(
        () -> assertNotSame(first, second),
        () -> assertNotSame(first, third),
        () -> assertNotSame(second, third)
    );
  }

  @Test
  void releasingShouldWork() throws NoPlanesAvailableException, ThisPlaneIsNotFromHereException {
    this.airport = new Airport(2);
    Plane one = this.airport.getPlane();
    Plane two = this.airport.getPlane();
    this.airport.releasePlane(one);
    Plane three = this.airport.getPlane();
    assertSame(one, three);
  }

  @Test
  void releasingFakePlaneShouldResultInException() {
    this.airport = new Airport(4);
    Plane fakePlane = new Plane();
    assertThrows(
        ThisPlaneIsNotFromHereException.class,
        () -> this.airport.releasePlane(fakePlane)
    );
  }
}