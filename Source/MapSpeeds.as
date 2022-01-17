class MapSpeeds{
    string mapId = '';
    string jsonFile = '';
    string pbKey = 'pb';
    string finishedKey = 'finished';
    string cpCountKey = 'cps';
    Json::Value speeds = Json::Object();

    string folder = '';

    MapSpeeds(){

    }

    MapSpeeds(string mapIdentifier, bool loadFromFile = true){
        if(mapIdentifier == '') return;

        string baseFolder = IO::FromDataFolder('');
        folder = baseFolder + 'splitspeeds';
        if(!IO::FolderExists(folder)){
            IO::CreateFolder(folder);
            print("Created folder: " + folder);
        }

        mapId = mapIdentifier;
        jsonFile = folder + '/' + mapId + ".json";
        if(loadFromFile){
            FromFile();
        }
    }

    bool GetFinished(){
        if(!speeds.HasKey(finishedKey))
            return false;
        bool finished = speeds[finishedKey];
        return finished;
    }

    void SetFinished(bool value){
        speeds[finishedKey] = value;
    }

    void Clear(){
        speeds = Json::Object();
        print("Clearing pb speeds! new speeds: " + Json::Write(speeds));
        Json::ToFile(jsonFile, speeds);
    }

    uint CpCount(){
        if(!speeds.HasKey(cpCountKey))
            return 0;
        return speeds[cpCountKey];
    }

    float GetCp(uint cpId){
        return speeds['' + cpId];
    }

    void SetCp(uint cpId, float speed){
        speeds['' + cpId] = speed;
    }

    bool HasCp(uint cpId){
        return speeds.HasKey('' + cpId);
    }

    void FromFile(){
        if(IO::FileExists(jsonFile)){
            // check validity of existing file
            IO::File f(jsonFile);
            f.Open(IO::FileMode::Read);
            auto content = f.ReadToEnd();
            f.Close();
            if(content == "" || content == "null"){
                warn("Invalid SplitSpeeds file detected");
                speeds = Json::Object();
            } else {
                speeds = Json::FromFile(jsonFile);
            }
        }
    }

    uint GetPb(){
        if(!speeds.HasKey(pbKey))
            return 0;
        return speeds[pbKey];
    }

    void ToFile(uint pbTime, uint cpCount){
        if(!IsValid()){
            warn("Trying to export invalid map speeds to file! aborting ToFile()");
            return;
        }
        speeds[pbKey] = pbTime;
        speeds[cpCountKey] = cpCount;
        print("Saving new pb (" + pbTime + ") cp (" + cpCount + ") finished (" + GetFinished() + ") to file: " + jsonFile);
        Json::ToFile(jsonFile, speeds);
    }

    bool IsValid(){
        for(uint i = 0; i < CpCount(); i++){
            if(!HasCp(i + 1))
                return false;
        }
        return true;
    }
};