package xyz.juraszek.swingobjecteditor.serializers;

import xyz.juraszek.swingobjecteditor.models.PhysicalReadableThingModel;

public interface PhysicalReadableThingSerializer {

  void serialize(PhysicalReadableThingSerializer prt);

  PhysicalReadableThingModel deserialize();
}
