class ControlCenter {
    var isLockedDown: Bool
    var securityCode: String
    
    init(isLockedDown: Bool, securityCode: String) {
        self.isLockedDown = isLockedDown
        self.securityCode = securityCode
    }
    
    func lockdown(with password: String) {
        if password == securityCode {
            isLockedDown = true
        }
    }
    
    func printLockdownStatus() {
        print("Control Center is locked down: \(isLockedDown)")
    }
}

class ResearchLab: StationModule {
    var researchSamples: [String] = []
    
    func addResearchSample(_ sample: String) {
        researchSamples.append(sample)
    }
}

class LifeSupportSystem: StationModule {
    var oxygenLevel: Int
    
    init(moduleName: String, oxygenLevel: Int) {
        self.oxygenLevel = oxygenLevel
        super.init(moduleName: moduleName)
    }
    
    func checkOxygenStatus() {
        print("Oxygen level: \(oxygenLevel)%")
    }
}

class StationModule {
    var moduleName: String
    var drone: Drone?
    
    init(moduleName: String) {
        self.moduleName = moduleName
    }
    
    func assignDrone(_ drone: Drone) {
        self.drone = drone
    }
}

class Drone {
    var task: String?
    unowned var assignedModule: StationModule
    weak var missionControlLink: MissionControl?
    
    init(assignedModule: StationModule) {
        self.assignedModule = assignedModule
    }
    
    func checkTask() {
        if let task = task {
            print("Drone in module \(assignedModule.moduleName) is performing task: \(task)")
        } else {
            print("Drone in module \(assignedModule.moduleName) is not assigned a task.")
        }
    }
}

class OrbitronSpaceStation {
    let controlCenter: ControlCenter
    let researchLab: ResearchLab
    let lifeSupportSystem: LifeSupportSystem
    
    init() {
        controlCenter = ControlCenter(isLockedDown: false, securityCode: "securePassword")
        researchLab = ResearchLab(moduleName: "Research Lab")
        lifeSupportSystem = LifeSupportSystem(moduleName: "Life Support", oxygenLevel: 95)
        
        // Create drones and assign them to modules
        let drone1 = Drone(assignedModule: researchLab)
        let drone2 = Drone(assignedModule: lifeSupportSystem)
        
        researchLab.assignDrone(drone1)
        lifeSupportSystem.assignDrone(drone2)
    }
    
    func lockdownOrbitronSpaceStation() {
        controlCenter.lockdown(with: "securePassword")
    }
}

class MissionControl {
    var spaceStation: OrbitronSpaceStation?
    
    func connectToSpaceStation(_ spaceStation: OrbitronSpaceStation) {
        self.spaceStation = spaceStation
    }
    
    func requestControlCenterStatus() {
        spaceStation?.controlCenter.printLockdownStatus()
    }
    
    func requestOxygenStatus() {
        spaceStation?.lifeSupportSystem.checkOxygenStatus()
    }
    
    func requestDroneStatus() {
        spaceStation?.researchLab.drone?.checkTask()
        spaceStation?.lifeSupportSystem.drone?.checkTask()
    }
}


let orbitronStation = OrbitronSpaceStation()
let missionControl = MissionControl()
missionControl.connectToSpaceStation(orbitronStation)

// ტესტ-დრაივი
orbitronStation.lockdownOrbitronSpaceStation()
missionControl.requestControlCenterStatus()
missionControl.requestOxygenStatus()
missionControl.requestDroneStatus()
