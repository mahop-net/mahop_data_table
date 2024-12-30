class RepairItem {
  String category;
  String task;
  String parts;
  double durationInHours;
  double partsPrice;

  RepairItem(this.category, this.task, this.parts, this.durationInHours,
      this.partsPrice);

  @override
  String toString() {
    return '$category; $task; $parts; $durationInHours; $partsPrice';
  }
}

List<RepairItem> generateRepairItemsEn() {
  return [
    RepairItem('Engine', 'Oil Change', 'Engine Oil, Oil Filter', 1.0, 30.00),
    RepairItem('Engine', 'Replace Air Filter', 'Air Filter', 0.5, 20.00),
    RepairItem('Engine', 'Replace Spark Plugs', 'Spark Plugs', 1.0, 40.00),
    RepairItem('Engine', 'Replace Timing Belt', 'Timing Belt', 4.0, 150.00),
    RepairItem('Engine', 'Replace Fuel Filter', 'Fuel Filter', 1.5, 50.00),
    RepairItem('Engine', 'Replace Coolant', 'Coolant', 1.0, 25.00),
    RepairItem('Engine', 'Replace Valve Cover Gasket', 'Valve Cover Gasket',
        2.0, 35.00),
    RepairItem(
        'Engine', 'Replace Serpentine Belt', 'Serpentine Belt', 1.5, 40.00),
    RepairItem('Engine', 'Replace Thermostat', 'Thermostat', 2.0, 45.00),
    RepairItem('Engine', 'Replace Water Pump', 'Water Pump', 3.0, 80.00),
    RepairItem('Transmission', 'Change Transmission Fluid',
        'Transmission Fluid', 2.0, 60.00),
    RepairItem('Transmission', 'Replace Clutch', 'Clutch Kit', 6.0, 250.00),
    RepairItem(
        'Transmission', 'Replace Shift Cable', 'Shift Cable', 2.5, 75.00),
    RepairItem(
        'Transmission', 'Replace Clutch Cable', 'Clutch Cable', 2.0, 60.00),
    RepairItem('Transmission', 'Replace CV Boot', 'CV Boot', 2.5, 45.00),
    RepairItem('Brakes', 'Replace Front Brake Pads', 'Brake Pads', 1.5, 80.00),
    RepairItem('Brakes', 'Replace Rear Brake Pads', 'Brake Pads', 1.5, 70.00),
    RepairItem(
        'Brakes', 'Replace Front Brake Discs', 'Brake Discs', 2.0, 100.00),
    RepairItem('Brakes', 'Replace Rear Brake Discs', 'Brake Discs', 2.0, 90.00),
    RepairItem('Brakes', 'Replace Brake Hoses', 'Brake Hoses', 3.0, 60.00),
    RepairItem('Brakes', 'Replace Brake Caliper', 'Brake Caliper', 2.5, 120.00),
    RepairItem('Brakes', 'Adjust Handbrake', 'None', 1.0, 0.00),
    RepairItem('Brakes', 'Change Brake Fluid', 'Brake Fluid', 1.5, 20.00),
    RepairItem('Brakes', 'Replace ABS Sensor', 'ABS Sensor', 1.5, 50.00),
    RepairItem(
        'Exhaust', 'Replace Exhaust System', 'Exhaust System', 2.0, 200.00),
    RepairItem('Exhaust', 'Replace Catalytic Converter', 'Catalytic Converter',
        3.0, 300.00),
    RepairItem('Exhaust', 'Replace Muffler', 'Muffler', 1.5, 150.00),
    RepairItem('Exhaust', 'Replace Exhaust Pipe', 'Exhaust Pipe', 2.0, 100.00),
    RepairItem(
        'Exhaust', 'Replace Exhaust Gaskets', 'Exhaust Gaskets', 1.0, 20.00),
    RepairItem('Suspension', 'Replace Front Shock Absorbers', 'Shock Absorbers',
        2.5, 200.00),
    RepairItem('Suspension', 'Replace Rear Shock Absorbers', 'Shock Absorbers',
        2.0, 180.00),
    RepairItem('Suspension', 'Replace Front Springs', 'Springs', 3.0, 150.00),
    RepairItem('Suspension', 'Replace Rear Springs', 'Springs', 2.5, 130.00),
    RepairItem('Suspension', 'Replace Tie Rod End', 'Tie Rod End', 1.5, 60.00),
    RepairItem('Suspension', 'Replace Control Arm', 'Control Arm', 2.0, 120.00),
    RepairItem(
        'Suspension', 'Replace Stabilizer Bar', 'Stabilizer Bar', 1.5, 80.00),
    RepairItem('Electrical', 'Replace Battery', 'Battery', 0.5, 100.00),
    RepairItem('Electrical', 'Replace Alternator', 'Alternator', 2.5, 250.00),
    RepairItem(
        'Electrical', 'Replace Starter Motor', 'Starter Motor', 2.0, 150.00),
    RepairItem('Electrical', 'Replace Headlight', 'Headlight', 1.0, 80.00),
    RepairItem('Electrical', 'Replace Brake Light', 'Brake Light', 0.5, 20.00),
    RepairItem(
        'Electrical', 'Replace Ignition Switch', 'Ignition Switch', 2.5, 90.00),
    RepairItem(
        'Electrical', 'Replace Window Motor', 'Window Motor', 2.0, 100.00),
    RepairItem(
        'Electrical', 'Replace AC Compressor', 'AC Compressor', 3.0, 300.00),
    RepairItem('Electrical', 'Replace Fuse Box', 'Fuse Box', 2.0, 60.00),
    RepairItem(
        'Electrical', 'Repair Wiring Harness', 'Wiring Harness', 4.0, 150.00),
    RepairItem('Body', 'Replace Windshield', 'Windshield', 3.0, 400.00),
    RepairItem('Body', 'Replace Rear Window', 'Rear Window', 2.5, 350.00),
    RepairItem('Body', 'Replace Side Window', 'Side Window', 2.0, 150.00),
    RepairItem('Body', 'Replace Front Bumper', 'Front Bumper', 2.5, 200.00),
    RepairItem('Body', 'Replace Rear Bumper', 'Rear Bumper', 2.5, 180.00),
    RepairItem('Body', 'Replace Fender', 'Fender', 3.0, 220.00),
    RepairItem('Body', 'Replace Door Lock', 'Door Lock', 2.0, 80.00),
    RepairItem('Body', 'Replace Door Handle', 'Door Handle', 1.5, 50.00),
    RepairItem('Body', 'Replace Side Mirror', 'Side Mirror', 1.0, 70.00),
    RepairItem('Body', 'Replace Hood', 'Hood', 3.5, 250.00),
    RepairItem('Body', 'Replace Trunk Lid', 'Trunk Lid', 3.0, 220.00),
    RepairItem('Body', 'Replace Rocker Panel', 'Rocker Panel', 4.0, 180.00),
    RepairItem(
        'Interior', 'Replace Seat Upholstery', 'Seat Upholstery', 2.5, 120.00),
    RepairItem('Interior', 'Replace Dashboard', 'Dashboard', 5.0, 300.00),
    RepairItem(
        'Interior', 'Replace Steering Wheel', 'Steering Wheel', 2.0, 150.00),
    RepairItem(
        'Interior', 'Replace Gear Shift Lever', 'Gear Shift Lever', 1.0, 80.00),
    RepairItem(
        'Interior', 'Replace Handbrake Lever', 'Handbrake Lever', 1.5, 70.00),
    RepairItem('Interior', 'Replace Floor Mats', 'Floor Mats', 0.5, 40.00),
    RepairItem('Interior', 'Replace Seat Belt', 'Seat Belt', 2.0, 90.00),
    RepairItem(
        'Interior', 'Replace Cabin Air Filter', 'Cabin Air Filter', 1.0, 25.00),
    RepairItem('Interior', 'Clean Air Conditioning System', 'None', 2.5, 0.00),
    RepairItem('Tires & Wheels', 'Replace Tires', 'Tires', 1.5, 200.00),
    RepairItem('Tires & Wheels', 'Balance Tires', 'None', 1.0, 0.00),
    RepairItem('Tires & Wheels', 'Replace Rims', 'Rims', 2.0, 400.00),
    RepairItem('Tires & Wheels', 'Replace Wheel Bearing', 'Wheel Bearing', 2.5,
        150.00),
    RepairItem('Tires & Wheels', 'Replace Lug Nuts', 'Lug Nuts', 1.0, 50.00),
    RepairItem('Tires & Wheels', 'Replace Tire Pressure Sensor',
        'Tire Pressure Sensor', 1.5, 80.00),
    RepairItem(
        'Tires & Wheels', 'Install Spare Tire', 'Spare Tire', 1.0, 100.00),
    RepairItem('Maintenance', 'Perform Inspection', 'None', 3.0, 0.00),
    RepairItem('Maintenance', 'Check Brakes', 'None', 1.5, 0.00),
    RepairItem('Maintenance', 'Check Suspension', 'None', 2.0, 0.00),
    RepairItem('Maintenance', 'Check Electrical System', 'None', 2.5, 0.00),
    RepairItem('Maintenance', 'Service Air Conditioning', 'None', 1.5, 0.00),
    RepairItem('Maintenance', 'Emissions Test', 'None', 1.0, 0.00),
    RepairItem('Maintenance', 'Prepare for MOT', 'None', 2.5, 0.00),
    RepairItem('Maintenance', 'Perform Winter Check', 'None', 1.5, 0.00),
    RepairItem('Maintenance', 'Perform Summer Check', 'None', 1.5, 0.00),
    RepairItem('Engine', 'Replace Engine Mounts', 'Engine Mounts', 3.0, 120.00),
    RepairItem('Engine', 'Replace Camshaft Position Sensor',
        'Camshaft Position Sensor', 2.0, 80.00),
    RepairItem('Engine', 'Replace Crankshaft Position Sensor',
        'Crankshaft Position Sensor', 2.0, 75.00),
    RepairItem(
        'Engine', 'Replace Oil Pan Gasket', 'Oil Pan Gasket', 4.0, 50.00),
    RepairItem('Engine', 'Replace Intake Manifold Gasket',
        'Intake Manifold Gasket', 3.0, 45.00),
    RepairItem('Engine', 'Replace Exhaust Manifold Gasket',
        'Exhaust Manifold Gasket', 3.0, 50.00),
    RepairItem('Transmission', 'Replace Gearbox', 'Gearbox', 6.0, 500.00),
    RepairItem(
        'Transmission', 'Replace Differential', 'Differential', 5.0, 400.00),
    RepairItem('Transmission', 'Replace Transmission Mount',
        'Transmission Mount', 2.5, 80.00),
    RepairItem(
        'Brakes', 'Replace Master Cylinder', 'Master Cylinder', 3.0, 150.00),
    RepairItem('Brakes', 'Replace Brake Booster', 'Brake Booster', 2.5, 180.00),
    RepairItem('Brakes', 'Replace Brake Proportioning Valve',
        'Brake Proportioning Valve', 2.0, 60.00),
    RepairItem(
        'Exhaust', 'Replace Oxygen Sensor', 'Oxygen Sensor', 1.5, 100.00),
    RepairItem('Exhaust', 'Replace Exhaust Heat Shield', 'Exhaust Heat Shield',
        2.0, 70.00),
    RepairItem(
        'Suspension', 'Replace Sway Bar Links', 'Sway Bar Links', 1.5, 50.00),
    RepairItem('Suspension', 'Replace Upper Control Arm', 'Upper Control Arm',
        3.0, 150.00),
    RepairItem('Suspension', 'Replace Lower Control Arm', 'Lower Control Arm',
        3.0, 150.00),
    RepairItem('Suspension', 'Replace Ball Joints', 'Ball Joints', 2.5, 100.00),
    RepairItem(
        'Suspension', 'Replace Coil Springs', 'Coil Springs', 3.5, 200.00),
    RepairItem(
        'Suspension', 'Replace Leaf Springs', 'Leaf Springs', 4.0, 250.00),
    RepairItem(
        'Electrical', 'Replace Blower Motor', 'Blower Motor', 2.0, 120.00),
    RepairItem('Electrical', 'Replace Windshield Wiper Motor', 'Wiper Motor',
        2.0, 100.00),
    RepairItem(
        'Electrical', 'Replace Wiper Blades', 'Wiper Blades', 0.5, 20.00),
    RepairItem('Electrical', 'Replace Power Steering Pump',
        'Power Steering Pump', 3.0, 180.00),
    RepairItem('Electrical', 'Replace Power Steering Hose',
        'Power Steering Hose', 2.0, 50.00),
    RepairItem(
        'Electrical', 'Replace Engine Control Unit (ECU)', 'ECU', 3.0, 400.00),
    RepairItem('Body', 'Replace Roof', 'Roof', 6.0, 500.00),
    RepairItem('Body', 'Replace Sunroof', 'Sunroof', 4.0, 350.00),
    RepairItem('Body', 'Replace Trunk Lock', 'Trunk Lock', 2.0, 80.00),
    RepairItem('Body', 'Replace Fuel Door', 'Fuel Door', 1.5, 40.00),
    RepairItem(
        'Body', 'Replace Body Side Molding', 'Body Side Molding', 3.0, 120.00),
    RepairItem('Interior', 'Replace Headliner', 'Headliner', 4.0, 200.00),
    RepairItem('Interior', 'Replace Carpet', 'Carpet', 3.5, 150.00),
    RepairItem('Interior', 'Replace Door Panel', 'Door Panel', 2.5, 100.00),
    RepairItem(
        'Interior', 'Replace Center Console', 'Center Console', 3.0, 150.00),
    RepairItem('Interior', 'Replace Glove Box', 'Glove Box', 2.0, 80.00),
    RepairItem(
        'Interior', 'Replace Interior Light Bulbs', 'Light Bulbs', 1.0, 20.00),
    RepairItem(
        'Tires & Wheels', 'Replace Valve Stems', 'Valve Stems', 1.0, 30.00),
    RepairItem('Tires & Wheels', 'Replace Hubcaps', 'Hubcaps', 1.5, 60.00),
    RepairItem('Tires & Wheels', 'Rotate Tires', 'None', 1.0, 0.00),
    RepairItem(
        'Tires & Wheels', 'Repair Flat Tire', 'Tire Repair Kit', 1.5, 20.00),
    RepairItem(
        'Tires & Wheels', 'Replace Tire Valve Caps', 'Valve Caps', 0.5, 10.00),
    RepairItem(
        'Maintenance', 'Replace Timing Chain', 'Timing Chain', 5.0, 200.00),
    RepairItem('Maintenance', 'Clean Fuel Injectors', 'Fuel Injector Cleaner',
        2.0, 30.00),
    RepairItem('Maintenance', 'Replace Fuel Pump', 'Fuel Pump', 3.0, 150.00),
    RepairItem('Maintenance', 'Flush Radiator', 'Radiator Flush', 2.5, 40.00),
    RepairItem(
        'Maintenance', 'Replace Radiator Hoses', 'Radiator Hoses', 2.0, 50.00),
    RepairItem('Maintenance', 'Replace PCV Valve', 'PCV Valve', 1.0, 25.00),
    RepairItem('Maintenance', 'Replace EGR Valve', 'EGR Valve', 2.5, 80.00),
    RepairItem('Maintenance', 'Replace Mass Air Flow Sensor',
        'Mass Air Flow Sensor', 1.5, 120.00),
    RepairItem('Maintenance', 'Replace Throttle Position Sensor',
        'Throttle Position Sensor', 1.5, 75.00),
    RepairItem(
        'Maintenance', 'Replace Knock Sensor', 'Knock Sensor', 2.0, 60.00),
    RepairItem('Engine', 'Replace Engine Coolant Temperature Sensor',
        'Coolant Temperature Sensor', 1.5, 30.00),
    RepairItem('Engine', 'Replace Idle Air Control Valve',
        'Idle Air Control Valve', 1.5, 50.00),
    RepairItem('Engine', 'Replace MAP Sensor', 'MAP Sensor', 1.5, 60.00),
    RepairItem('Transmission', 'Replace Transmission Cooler',
        'Transmission Cooler', 3.0, 120.00),
    RepairItem('Transmission', 'Replace Flywheel', 'Flywheel', 4.5, 200.00),
    RepairItem('Brakes', 'Replace Parking Brake Cable', 'Parking Brake Cable',
        2.0, 50.00),
    RepairItem('Brakes', 'Replace Brake Shoes', 'Brake Shoes', 2.5, 60.00),
    RepairItem('Exhaust', 'Replace Exhaust Tips', 'Exhaust Tips', 1.5, 40.00),
    RepairItem('Exhaust', 'Replace Exhaust Resonator', 'Exhaust Resonator', 2.0,
        80.00),
    RepairItem('Suspension', 'Replace Subframe Bushings', 'Subframe Bushings',
        3.5, 150.00),
    RepairItem('Suspension', 'Replace Strut Tower Brace', 'Strut Tower Brace',
        2.0, 100.00),
    RepairItem('Electrical', 'Replace Tail Light', 'Tail Light', 1.0, 70.00),
    RepairItem('Electrical', 'Replace Horn', 'Horn', 1.5, 30.00),
    RepairItem('Body', 'Replace Grille', 'Grille', 1.5, 90.00),
    RepairItem('Body', 'Replace Spoiler', 'Spoiler', 2.5, 150.00),
    RepairItem('Body', 'Replace Badge', 'Badge', 1.0, 20.00),
    RepairItem('Interior', 'Replace Pedal Pads', 'Pedal Pads', 1.0, 20.00),
    RepairItem(
        'Interior', 'Replace Rearview Mirror', 'Rearview Mirror', 1.5, 50.00),
    RepairItem('Interior', 'Replace Sun Visor', 'Sun Visor', 1.0, 30.00),
    RepairItem(
        'Tires & Wheels', 'Install Wheel Locks', 'Wheel Locks', 1.0, 50.00),
    RepairItem('Tires & Wheels', 'Replace Wheel Hub', 'Wheel Hub', 2.5, 150.00),
    RepairItem('Maintenance', 'Check Wheel Alignment', 'None', 2.0, 0.00),
    RepairItem('Maintenance', 'Replace Windshield Washer Pump', 'Washer Pump',
        1.5, 40.00),
    RepairItem('Maintenance', 'Replace Windshield Washer Nozzles',
        'Washer Nozzles', 1.0, 20.00),
    RepairItem(
        'Maintenance', 'Replace Rear Wiper Blade', 'Wiper Blade', 0.5, 15.00),
    RepairItem(
        'Maintenance', 'Replace Front Wiper Arms', 'Wiper Arms', 1.0, 30.00),
    RepairItem('Maintenance', 'Replace Rear Wiper Arm', 'Wiper Arm', 1.0, 20.00)
  ];
}

List<RepairItem> generateRepairItemsDe() {
  return [
    RepairItem('Motor', 'Ölwechsel', 'Motoröl, Ölfilter', 1.0, 30.00),
    RepairItem('Motor', 'Luftfilter wechseln', 'Luftfilter', 0.5, 20.00),
    RepairItem('Motor', 'Zündkerzen wechseln', 'Zündkerzen', 1.0, 40.00),
    RepairItem('Motor', 'Zahnriemen wechseln', 'Zahnriemen', 4.0, 150.00),
    RepairItem(
        'Motor', 'Kraftstofffilter wechseln', 'Kraftstofffilter', 1.5, 50.00),
    RepairItem('Motor', 'Kühlmittel wechseln', 'Kühlmittel', 1.0, 25.00),
    RepairItem('Motor', 'Ventildeckeldichtung wechseln', 'Ventildeckeldichtung',
        2.0, 35.00),
    RepairItem('Motor', 'Keilriemen wechseln', 'Keilriemen', 1.5, 40.00),
    RepairItem('Motor', 'Thermostat wechseln', 'Thermostat', 2.0, 45.00),
    RepairItem('Motor', 'Wasserpumpe wechseln', 'Wasserpumpe', 3.0, 80.00),
    RepairItem('Getriebe', 'Getriebeöl wechseln', 'Getriebeöl', 2.0, 60.00),
    RepairItem('Getriebe', 'Kupplung wechseln', 'Kupplungssatz', 6.0, 250.00),
    RepairItem('Getriebe', 'Schaltkabel wechseln', 'Schaltkabel', 2.5, 75.00),
    RepairItem(
        'Getriebe', 'Kupplungskabel wechseln', 'Kupplungskabel', 2.0, 60.00),
    RepairItem('Getriebe', 'CV-Gelenk Manschette wechseln',
        'CV-Gelenk Manschette', 2.5, 45.00),
    RepairItem(
        'Bremsen', 'Vordere Bremsbeläge wechseln', 'Bremsbeläge', 1.5, 80.00),
    RepairItem(
        'Bremsen', 'Hintere Bremsbeläge wechseln', 'Bremsbeläge', 1.5, 70.00),
    RepairItem('Bremsen', 'Vordere Bremsscheiben wechseln', 'Bremsscheiben',
        2.0, 100.00),
    RepairItem('Bremsen', 'Hintere Bremsscheiben wechseln', 'Bremsscheiben',
        2.0, 90.00),
    RepairItem(
        'Bremsen', 'Bremsleitungen wechseln', 'Bremsleitungen', 3.0, 60.00),
    RepairItem('Bremsen', 'Bremszange wechseln', 'Bremszange', 2.5, 120.00),
    RepairItem('Bremsen', 'Handbremse einstellen', 'Keine', 1.0, 0.00),
    RepairItem(
        'Bremsen', 'Bremsflüssigkeit wechseln', 'Bremsflüssigkeit', 1.5, 20.00),
    RepairItem('Bremsen', 'ABS Sensor wechseln', 'ABS Sensor', 1.5, 50.00),
    RepairItem(
        'Auspuff', 'Auspuffanlage wechseln', 'Auspuffanlage', 2.0, 200.00),
    RepairItem('Auspuff', 'Katalysator wechseln', 'Katalysator', 3.0, 300.00),
    RepairItem('Auspuff', 'Endschalldämpfer wechseln', 'Endschalldämpfer', 1.5,
        150.00),
    RepairItem('Auspuff', 'Auspuffrohr wechseln', 'Auspuffrohr', 2.0, 100.00),
    RepairItem('Auspuff', 'Auspuffdichtungen wechseln', 'Auspuffdichtungen',
        1.0, 20.00),
    RepairItem(
        'Fahrwerk', 'Vordere Stoßdämpfer wechseln', 'Stoßdämpfer', 2.5, 200.00),
    RepairItem(
        'Fahrwerk', 'Hintere Stoßdämpfer wechseln', 'Stoßdämpfer', 2.0, 180.00),
    RepairItem('Fahrwerk', 'Vordere Federn wechseln', 'Federn', 3.0, 150.00),
    RepairItem('Fahrwerk', 'Hintere Federn wechseln', 'Federn', 2.5, 130.00),
    RepairItem(
        'Fahrwerk', 'Spurstangenkopf wechseln', 'Spurstangenkopf', 1.5, 60.00),
    RepairItem('Fahrwerk', 'Querlenker wechseln', 'Querlenker', 2.0, 120.00),
    RepairItem('Fahrwerk', 'Stabilisator wechseln', 'Stabilisator', 1.5, 80.00),
    RepairItem('Elektrik', 'Batterie wechseln', 'Batterie', 0.5, 100.00),
    RepairItem(
        'Elektrik', 'Lichtmaschine wechseln', 'Lichtmaschine', 2.5, 250.00),
    RepairItem('Elektrik', 'Starter wechseln', 'Starter', 2.0, 150.00),
    RepairItem('Elektrik', 'Scheinwerfer wechseln', 'Scheinwerfer', 1.0, 80.00),
    RepairItem('Elektrik', 'Bremslicht wechseln', 'Bremslicht', 0.5, 20.00),
    RepairItem('Elektrik', 'Zündschloss wechseln', 'Zündschloss', 2.5, 90.00),
    RepairItem('Elektrik', 'Fensterhebermotor wechseln', 'Fensterhebermotor',
        2.0, 100.00),
    RepairItem(
        'Elektrik', 'Klimakompressor wechseln', 'Klimakompressor', 3.0, 300.00),
    RepairItem('Elektrik', 'Sicherungskasten wechseln', 'Sicherungskasten', 2.0,
        60.00),
    RepairItem('Elektrik', 'Kabelbaum reparieren', 'Kabelbaum', 4.0, 150.00),
    RepairItem(
        'Karosserie', 'Frontscheibe wechseln', 'Frontscheibe', 3.0, 400.00),
    RepairItem(
        'Karosserie', 'Heckscheibe wechseln', 'Heckscheibe', 2.5, 350.00),
    RepairItem(
        'Karosserie', 'Seitenscheibe wechseln', 'Seitenscheibe', 2.0, 150.00),
    RepairItem('Karosserie', 'Frontstoßstange wechseln', 'Frontstoßstange', 2.5,
        200.00),
    RepairItem(
        'Karosserie', 'Heckstoßstange wechseln', 'Heckstoßstange', 2.5, 180.00),
    RepairItem('Karosserie', 'Kotflügel wechseln', 'Kotflügel', 3.0, 220.00),
    RepairItem('Karosserie', 'Türschloss wechseln', 'Türschloss', 2.0, 80.00),
    RepairItem('Karosserie', 'Türgriff wechseln', 'Türgriff', 1.5, 60.00),
    RepairItem(
        'Karosserie', 'Außenspiegel wechseln', 'Außenspiegel', 1.0, 100.00),
    RepairItem('Innenraum', 'Sitzpolsterung reparieren', 'Sitzpolsterung', 3.0,
        180.00),
    RepairItem('Innenraum', 'Lenkrad wechseln', 'Lenkrad', 2.0, 120.00),
    RepairItem(
        'Innenraum', 'Handschuhfach wechseln', 'Handschuhfach', 1.5, 50.00),
    RepairItem(
        'Innenraum', 'Mittelkonsole wechseln', 'Mittelkonsole', 2.0, 100.00),
    RepairItem(
        'Innenraum', 'Armaturenbrett wechseln', 'Armaturenbrett', 3.0, 150.00),
    RepairItem('Innenraum', 'Fußmatten wechseln', 'Fußmatten', 1.0, 40.00),
    RepairItem('Räder & Reifen', 'Reifenwechsel', 'Keine', 0.5, 0.00),
    RepairItem('Räder & Reifen', 'Reifen auswuchten', 'Keine', 1.0, 20.00),
    RepairItem('Räder & Reifen', 'Radlager wechseln', 'Radlager', 2.0, 80.00),
    RepairItem('Räder & Reifen', 'Felgen reparieren', 'Felgen', 1.5, 60.00),
    RepairItem(
        'Räder & Reifen', 'Reifenventil wechseln', 'Reifenventil', 0.5, 10.00),
    RepairItem('Wartung', 'Inspektion durchführen', 'Keine', 3.0, 0.00),
    RepairItem('Wartung', 'Ölstand prüfen', 'Keine', 0.5, 0.00),
    RepairItem('Wartung', 'Bremsen überprüfen', 'Keine', 1.0, 0.00),
    RepairItem('Wartung', 'Fahrzeugdiagnose durchführen', 'Keine', 2.0, 0.00),
    RepairItem('Wartung', 'Klimaanlage warten', 'Keine', 1.5, 0.00),
    RepairItem(
        'Wartung', 'Ölwechsel für Winter vorbereiten', 'Keine', 1.0, 0.00),
    RepairItem(
        'Wartung', 'Ölwechsel für Sommer vorbereiten', 'Keine', 1.0, 0.00),
    RepairItem('Motor', 'Motorlager wechseln', 'Motorlager', 2.5, 120.00),
    RepairItem('Motor', 'Nockenwellensensor wechseln', 'Nockenwellensensor',
        1.5, 60.00),
    RepairItem('Motor', 'Kurbelwellensensor wechseln', 'Kurbelwellensensor',
        1.5, 70.00),
    RepairItem(
        'Motor', 'Ölwannendichtung wechseln', 'Ölwannendichtung', 4.0, 50.00),
    RepairItem('Motor', 'Ansaugkrümmerdichtung wechseln',
        'Ansaugkrümmerdichtung', 3.0, 45.00),
    RepairItem('Motor', 'Abgaskrümmerdichtung wechseln', 'Abgaskrümmerdichtung',
        3.0, 50.00),
    RepairItem('Getriebe', 'Getriebe ersetzen', 'Getriebe', 6.0, 500.00),
    RepairItem(
        'Getriebe', 'Differential ersetzen', 'Differential', 5.0, 400.00),
    RepairItem(
        'Getriebe', 'Getriebelager ersetzen', 'Getriebelager', 2.5, 80.00),
    RepairItem('Bremsen', 'Hauptbremszylinder ersetzen', 'Hauptbremszylinder',
        3.0, 150.00),
    RepairItem('Bremsen', 'Bremskraftverstärker ersetzen',
        'Bremskraftverstärker', 2.5, 180.00),
    RepairItem(
        'Bremsen', 'Bremsdruckregler ersetzen', 'Bremsdruckregler', 2.0, 60.00),
    RepairItem('Auspuff', 'Sauerstoffsensor ersetzen', 'Sauerstoffsensor', 1.5,
        100.00),
    RepairItem('Auspuff', 'Auspuff-Hitzeschild ersetzen', 'Auspuff-Hitzeschild',
        2.0, 70.00),
    RepairItem('Fahrwerk', 'Stabilisatorverbindungen ersetzen',
        'Stabilisatorverbindungen', 1.5, 50.00),
    RepairItem('Fahrwerk', 'Obere Querlenker ersetzen', 'Obere Querlenker', 3.0,
        150.00),
    RepairItem('Fahrwerk', 'Untere Querlenker ersetzen', 'Untere Querlenker',
        3.0, 150.00),
    RepairItem('Fahrwerk', 'Spurstangenköpfe ersetzen', 'Spurstangenköpfe', 2.5,
        100.00),
    RepairItem('Fahrwerk', 'Federn ersetzen', 'Federn', 3.5, 200.00),
    RepairItem('Fahrwerk', 'Blattfedern ersetzen', 'Blattfedern', 4.0, 250.00),
    RepairItem(
        'Elektrik', 'Gebläsemotor ersetzen', 'Gebläsemotor', 2.0, 120.00),
    RepairItem('Elektrik', 'Scheibenwischermotor ersetzen',
        'Scheibenwischermotor', 2.0, 100.00),
    RepairItem('Elektrik', 'Scheibenwischerblätter ersetzen',
        'Scheibenwischerblätter', 0.5, 20.00),
    RepairItem(
        'Elektrik', 'Servolenkpumpe ersetzen', 'Servolenkpumpe', 3.0, 180.00),
    RepairItem('Elektrik', 'Servolenkschlauch ersetzen', 'Servolenkschlauch',
        2.0, 50.00),
    RepairItem('Elektrik', 'Motorsteuergerät (ECU) ersetzen',
        'Motorsteuergerät', 3.0, 400.00),
    RepairItem('Karosserie', 'Dach ersetzen', 'Dach', 6.0, 500.00),
    RepairItem(
        'Karosserie', 'Schiebedach ersetzen', 'Schiebedach', 4.0, 350.00),
    RepairItem('Karosserie', 'Kofferraumschloss ersetzen', 'Kofferraumschloss',
        2.0, 80.00),
    RepairItem('Karosserie', 'Tankdeckel ersetzen', 'Tankdeckel', 1.5, 40.00),
    RepairItem(
        'Karosserie', 'Seitenleisten ersetzen', 'Seitenleisten', 3.0, 120.00),
    RepairItem('Innenraum', 'Dachhimmel ersetzen', 'Dachhimmel', 4.0, 200.00),
    RepairItem(
        'Innenraum', 'Teppichboden ersetzen', 'Teppichboden', 3.5, 150.00),
    RepairItem(
        'Innenraum', 'Türverkleidung ersetzen', 'Türverkleidung', 2.5, 100.00),
    RepairItem(
        'Innenraum', 'Mittelkonsole ersetzen', 'Mittelkonsole', 3.0, 150.00),
    RepairItem('Innenraum', 'Armlehne ersetzen', 'Armlehne', 1.5, 60.00),
    RepairItem('Innenraum', 'Instrumententafel ersetzen', 'Instrumententafel',
        3.5, 180.00),
    RepairItem(
        'Innenraum', 'Lautsprecher ersetzen', 'Lautsprecher', 1.0, 40.00),
    RepairItem('Räder & Reifen', 'Reifendrucksensor ersetzen',
        'Reifendrucksensor', 1.0, 50.00),
    RepairItem('Räder & Reifen', 'Radkappen ersetzen', 'Radkappen', 1.0, 30.00),
    RepairItem(
        'Wartung', 'Kraftstofffilter ersetzen', 'Kraftstofffilter', 1.5, 40.00),
    RepairItem('Wartung', 'Zündkerzen ersetzen', 'Zündkerzen', 1.0, 30.00),
    RepairItem('Wartung', 'Luftfilter ersetzen', 'Luftfilter', 1.0, 25.00),
    RepairItem(
        'Wartung', 'Innenraumfilter ersetzen', 'Innenraumfilter', 1.0, 30.00),
    RepairItem('Wartung', 'Klimaanlagenfilter ersetzen', 'Klimaanlagenfilter',
        1.0, 30.00),
    RepairItem('Wartung', 'Kühlmittel ersetzen', 'Kühlmittel', 1.0, 20.00),
    RepairItem(
        'Wartung', 'Bremsflüssigkeit ersetzen', 'Bremsflüssigkeit', 1.5, 30.00),
    RepairItem('Motor', 'Austausch Motor', 'Motor', 8.0, 1000.00),
    RepairItem('Motor', 'Austausch Turbolader', 'Turbolader', 5.0, 800.00),
    RepairItem('Getriebe', 'Austausch Kupplung', 'Kupplung', 6.0, 500.00),
    RepairItem(
        'Getriebe', 'Austausch Differential', 'Differential', 5.0, 700.00),
    RepairItem('Bremsen', 'Austausch Bremssättel', 'Bremssättel', 3.0, 250.00),
    RepairItem(
        'Bremsen', 'Austausch Bremsleitungen', 'Bremsleitungen', 2.5, 120.00),
    RepairItem(
        'Auspuff', 'Austausch Auspuffkrümmer', 'Auspuffkrümmer', 3.0, 300.00),
    RepairItem('Auspuff', 'Austausch Lambdasonde', 'Lambdasonde', 1.5, 120.00),
    RepairItem('Fahrwerk', 'Austausch Stoßdämpfer', 'Stoßdämpfer', 2.5, 200.00),
    RepairItem('Fahrwerk', 'Austausch Federbein', 'Federbein', 3.0, 250.00),
    RepairItem('Fahrwerk', 'Austausch Federbalg', 'Federbalg', 2.0, 150.00),
    RepairItem('Elektrik', 'Austausch Kabelbaum', 'Kabelbaum', 5.0, 300.00),
    RepairItem('Elektrik', 'Austausch Batterie', 'Batterie', 1.0, 120.00),
    RepairItem(
        'Elektrik', 'Austausch Lichtmaschine', 'Lichtmaschine', 3.0, 350.00),
    RepairItem('Elektrik', 'Austausch Anlasser', 'Anlasser', 2.0, 180.00),
    RepairItem('Elektrik', 'Austausch Sicherungskasten', 'Sicherungskasten',
        2.5, 150.00),
    RepairItem('Karosserie', 'Austausch Kotflügel', 'Kotflügel', 3.0, 200.00),
    RepairItem('Karosserie', 'Austausch Motorhaube', 'Motorhaube', 2.5, 250.00),
    RepairItem('Karosserie', 'Austausch Tür', 'Tür', 3.0, 300.00),
    RepairItem('Karosserie', 'Austausch Heckklappe', 'Heckklappe', 3.5, 350.00),
    RepairItem('Innenraum', 'Austausch Sitze', 'Sitze', 4.0, 400.00),
    RepairItem(
        'Innenraum', 'Austausch Armaturenbrett', 'Armaturenbrett', 3.5, 300.00),
    RepairItem('Innenraum', 'Austausch Lenkrad', 'Lenkrad', 2.0, 150.00),
    RepairItem(
        'Innenraum', 'Austausch Schaltknüppel', 'Schaltknüppel', 1.5, 100.00),
    RepairItem('Räder & Reifen', 'Austausch Reifen', 'Reifen', 1.0, 80.00),
    RepairItem('Räder & Reifen', 'Austausch Felgen', 'Felgen', 1.5, 120.00),
    RepairItem('Wartung', 'Klimaservice', 'Keine', 2.0, 100.00),
    RepairItem('Wartung', 'Zündanlage prüfen', 'Keine', 1.0, 0.00),
    RepairItem('Wartung', 'Achsmanschetten prüfen', 'Keine', 0.5, 0.00),
    RepairItem('Wartung', 'Gaszug prüfen', 'Keine', 0.5, 0.00),
    RepairItem('Wartung', 'Stoßdämpfer prüfen', 'Keine', 1.0, 0.00),
    RepairItem('Wartung', 'Lenkung prüfen', 'Keine', 1.0, 0.00),
    RepairItem('Motor', 'Austausch Kurbelwelle', 'Kurbelwelle', 6.0, 600.00),
    RepairItem('Motor', 'Austausch Nockenwelle', 'Nockenwelle', 5.0, 500.00),
    RepairItem('Motor', 'Austausch Ölwanne', 'Ölwanne', 3.0, 100.00),
    RepairItem('Motor', 'Austausch Ventildeckel', 'Ventildeckel', 2.0, 80.00),
    RepairItem(
        'Motor', 'Austausch Kurbelgehäuse', 'Kurbelgehäuse', 4.0, 300.00),
    RepairItem('Getriebe', 'Austausch Getriebegehäuse', 'Getriebegehäuse', 7.0,
        700.00),
    RepairItem(
        'Getriebe', 'Austausch Antriebswelle', 'Antriebswelle', 4.0, 400.00),
    RepairItem(
        'Getriebe', 'Austausch Synchronringe', 'Synchronringe', 5.0, 500.00),
    RepairItem(
        'Getriebe', 'Austausch Schaltgetriebe', 'Schaltgetriebe', 6.0, 600.00),
    RepairItem(
        'Bremsen', 'Austausch Bremsscheiben', 'Bremsscheiben', 2.0, 150.00),
    RepairItem(
        'Bremsen', 'Austausch Bremszylinder', 'Bremszylinder', 3.0, 200.00),
    RepairItem('Bremsen', 'Austausch Bremsklötze', 'Bremsklötze', 1.5, 100.00),
    RepairItem(
        'Bremsen', 'Austausch Handbremsseil', 'Handbremsseil', 2.0, 120.00),
    RepairItem('Bremsen', 'Austausch Bremsbacken', 'Bremsbacken', 1.5, 100.00),
    RepairItem('Auspuff', 'Austausch Endschalldämpfer', 'Endschalldämpfer', 3.0,
        250.00),
    RepairItem('Auspuff', 'Austausch Vorschalldämpfer', 'Vorschalldämpfer', 2.0,
        180.00),
    RepairItem('Fahrwerk', 'Austausch Radlager', 'Radlager', 2.5, 150.00),
    RepairItem(
        'Fahrwerk', 'Austausch Koppelstangen', 'Koppelstangen', 1.5, 80.00),
    RepairItem('Fahrwerk', 'Austausch Spurstangen', 'Spurstangen', 3.0, 200.00),
    RepairItem('Fahrwerk', 'Austausch Traggelenke', 'Traggelenke', 3.0, 250.00),
    RepairItem(
        'Elektrik', 'Austausch Lichtkabelbaum', 'Lichtkabelbaum', 2.5, 150.00),
    RepairItem('Elektrik', 'Austausch Schaltereinheit', 'Schaltereinheit', 1.5,
        100.00),
    RepairItem('Elektrik', 'Austausch Relais', 'Relais', 1.0, 30.00),
    RepairItem(
        'Karosserie', 'Austausch Scheinwerfer', 'Scheinwerfer', 2.5, 200.00),
    RepairItem(
        'Karosserie', 'Austausch Heckleuchten', 'Heckleuchten', 2.0, 150.00),
    RepairItem('Karosserie', 'Austausch Blinker', 'Blinker', 1.0, 50.00),
    RepairItem('Karosserie', 'Austausch Kennzeichenbeleuchtung',
        'Kennzeichenbeleuchtung', 1.0, 20.00),
    RepairItem('Innenraum', 'Austausch Rückspiegel', 'Rückspiegel', 1.0, 60.00),
    RepairItem('Innenraum', 'Austausch Spiegelglas', 'Spiegelglas', 1.0, 40.00),
    RepairItem('Innenraum', 'Austausch Schaltsack', 'Schaltsack', 0.5, 30.00),
    RepairItem(
        'Innenraum', 'Austausch Sonnenblende', 'Sonnenblende', 0.5, 20.00),
    RepairItem('Räder & Reifen', 'Austausch Radnabe', 'Radnabe', 1.0, 80.00),
    RepairItem(
        'Wartung', 'Austausch Wischermotor', 'Wischermotor', 1.5, 100.00),
    RepairItem('Wartung', 'Austausch Wischwasserpumpe', 'Wischtasserpumpe', 1.5,
        100.00),
    RepairItem(
        'Wartung', 'Austausch Kühlwasserpumpe', 'Kühlwasserpumpe', 2.0, 120.00),
    RepairItem(
        'Wartung', 'Austausch Starterbatterie', 'Starterbatterie', 1.5, 150.00),
    RepairItem('Wartung', 'Austausch Zahnriemen', 'Zahnriemen', 4.0, 300.00),
    RepairItem('Wartung', 'Austausch Keilriemen', 'Keilriemen', 1.5, 100.00),
    RepairItem('Motor', 'Austausch Zylinderkopfdichtung',
        'Zylinderkopfdichtung', 6.0, 600.00),
    RepairItem('Motor', 'Austausch Kolbenringe', 'Kolbenringe', 4.0, 400.00),
    RepairItem('Motor', 'Austausch Pleuellager', 'Pleuellager', 3.0, 300.00),
    RepairItem('Motor', 'Austausch Hauptlager', 'Hauptlager', 5.0, 500.00),
    RepairItem('Getriebe', 'Austausch Wandler', 'Wandler', 6.0, 600.00),
    RepairItem('Getriebe', 'Austausch Zahnrad', 'Zahnrad', 5.0, 500.00),
    RepairItem(
        'Getriebe', 'Austausch Antriebsriemen', 'Antriebsriemen', 3.0, 300.00),
    RepairItem('Getriebe', 'Austausch Ölpumpe', 'Ölpumpe', 4.0, 400.00),
    RepairItem('Bremsen', 'Austausch Handbremse', 'Handbremse', 3.0, 300.00),
    RepairItem('Bremsen', 'Austausch Bremsflüssigkeitsbehälter',
        'Bremsflüssigkeitsbehälter', 3.0, 300.00),
    RepairItem('Bremsen', 'Austausch Bremskraftverstärker',
        'Bremskraftverstärker', 2.5, 250.00),
    RepairItem('Bremsen', 'Austausch Bremsseil', 'Bremsseil', 2.0, 200.00),
    RepairItem('Auspuff', 'Austausch Auspufftopf', 'Auspufftopf', 4.0, 400.00),
    RepairItem('Auspuff', 'Austausch Katalysator', 'Katalysator', 3.0, 300.00),
    RepairItem('Auspuff', 'Austausch Endrohr', 'Endrohr', 2.0, 200.00),
    RepairItem('Auspuff', 'Austausch Dichtung', 'Dichtung', 1.0, 100.00),
    RepairItem('Fahrwerk', 'Austausch Domlager', 'Domlager', 1.5, 150.00),
    RepairItem('Fahrwerk', 'Austausch Schwinge', 'Schwinge', 3.0, 300.00),
    RepairItem('Fahrwerk', 'Austausch Querlenker', 'Querlenker', 2.5, 250.00),
    RepairItem(
        'Fahrwerk', 'Austausch Schraubenfeder', 'Schraubenfeder', 3.5, 350.00),
    RepairItem('Fahrwerk', 'Austausch Achsstreben', 'Achsstreben', 4.0, 400.00),
    RepairItem('Elektrik', 'Austausch Schalter', 'Schalter', 1.5, 150.00),
    RepairItem('Elektrik', 'Austausch Stecker', 'Stecker', 1.0, 100.00),
    RepairItem('Elektrik', 'Austausch Dioden', 'Dioden', 0.5, 50.00),
    RepairItem('Elektrik', 'Austausch Spulen', 'Spulen', 0.5, 50.00),
    RepairItem('Elektrik', 'Austausch Kontakte', 'Kontakte', 0.5, 50.00),
  ];
}
