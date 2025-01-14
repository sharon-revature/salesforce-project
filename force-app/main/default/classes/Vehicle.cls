public abstract class Vehicle {
    // Enum Medium with values LAND, AIR, WATER
    public enum Medium {LAND, AIR, WATER}
    
    // Speed property: read-only outside of class, non-negative
    private Integer Speed;
    public Integer getSpeed() {
        return Speed;
    }
    public void setSpeed(Integer speed) {
        if (speed < 0) {
            this.Speed = 0;
        } else {
            this.Speed = speed;
        }
    }
    
    // Name property: read-only outside of class
    private String Name;
    public String getName() {
        return this.Name;
    }
    
    // Occupants property: non-negative
    private Integer Occupants;
    public Integer getOccupants() {
        return this.Occupants;
    }
    public void setOccupants(Integer occupants) {
        if (occupants < 0) {
            this.Occupants = 0;
        } else {
            this.Occupants = occupants;
        }
    }
    
    // Capacity constant: at least 1
    private static final Integer CAPACITY = 1;
    
    // Media variable: a list of Mediums; only accessible by class and its children
    private List<Medium> Media;
    protected List<Medium> getMedia() {
        return Media;
    }
    
    public Vehicle(String name, Integer speed, Integer occupants) {
        this.Name = name;
        this.Speed = speed;
        this.Occupants = occupants;
        
        // Ensure Capacity is at least 1
        this.Media = new List<Medium>();
    }
    
    public Vehicle() {
        // Constructor chaining: Calls the primary constructor with default values
        this('Default Name', 0, 0);
    }
    
    // Accelerate method: change speed by the specified amount
    public virtual void Accelerate(Integer speedChange) {
        Speed += speedChange;
    }
    
    // Turn abstract method
    public abstract Integer Turn(Integer angle);
    
    // ToString method: print out current Speed, all Media, Name, and # Occupants
    public override String ToString() {
        String mediaList = '';
        for (Medium m : Media) {
            mediaList += m + ', ';
        }
        return 'Speed: ' + Speed + ', Media: ' + mediaList + ', Name: ' + Name + ', Occupants: ' + Occupants;
    }
}