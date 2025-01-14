public class Car extends Vehicle {
    // SteeringRotation private variable: -1440 to 1440 inclusive
    private Integer SteeringRotation;
    
    private void setSteeringRotation(Integer value) {
        // Ensuring SteeringRotation stays within the range -1440 to 1440
        this.SteeringRotation = Math.min(1440, Math.max(-1440, value));
    }
    
    // TireRotation property: read-only outside of class; -90 to 90 inclusive
    private Integer TireRotation;
    
    public Integer getTireRotation() {
        return TireRotation;
    }
    
    private void setTireRotation(Integer value) {
        // Ensuring TireRotation stays within the range -90 to 90
        this.TireRotation = Math.min(90, Math.max(-90, value));
    }
    
    // Gear property: read-only outside of class
    private Integer Gear;
    
    public Integer getGear() {
        return Gear;
    }
    
    // Constructor
    public Car(String name, Integer speed, Integer occupants, Integer capacity) {
        // Call the base constructor of Vehicle
        super(name, speed, occupants);
        
        // Initialize rotation values
        this.SteeringRotation = 0;
        this.TireRotation = 0;
        
        // Add the LAND medium to the Media list
        this.getMedia().add(Medium.LAND);
    }
    
    // Default Constructor (chained to parameterized constructor)
    public Car() {
        this('Default Car', 0, 0, 1); // Added default capacity
    }
    
    // Override Accelerate Method
    public override void Accelerate(Integer amount) {
        super.Accelerate(amount);
        
        // Calculate Gear using the given equation
        this.Gear = (Integer) Math.ceil(0.4444 * Math.sqrt(this.getSpeed()));
    }
    
    // Override Turn method
    public override Integer Turn(Integer angle) {
        // Adjust SteeringRotation by the specified angle
        this.SteeringRotation += angle;
        
        // Adjust TireRotation by 1/16th of the specified angle
        this.TireRotation += (Integer) Math.floor(angle / 16);
        
        // Return the updated SteeringRotation
        return this.SteeringRotation;
    }
}