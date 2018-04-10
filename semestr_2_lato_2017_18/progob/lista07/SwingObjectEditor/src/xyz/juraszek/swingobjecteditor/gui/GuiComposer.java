package xyz.juraszek.swingobjecteditor.gui;

import java.util.HashMap;
import xyz.juraszek.swingobjecteditor.models.PhysicalReadableThingModel;
import xyz.juraszek.swingobjecteditor.serializers.PhysicalReadableThingSerializer;

public class GuiComposer {

  private HashMap<String, PhysicalReadableThingModel> models;
  private HashMap<String, PhysicalReadableThingSerializer> serializers;

  public GuiComposer() {
    this.models = new HashMap<>();
    this.serializers = new HashMap<>();
  }

  public void registerClassHandler(
      String className,
      PhysicalReadableThingModel model,
      PhysicalReadableThingSerializer serializer) {

    this.models.put(className, model);
    this.serializers.put(className, serializer);
  }

  public void showEditor(String className) {
    // TODO
  }
}
