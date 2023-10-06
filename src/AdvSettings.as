namespace AdvSettings{
    void Render(){
        if (UI::Button("Clear current map pb speeds")){
            UI::ShowNotification("Cleared pb speeds for current map", 5000);
            mapSpeeds.ClearPB();
        }
        if (UI::Button("Clear all stored pb speeds")){
            if(IO::FolderExists(IO::FromStorageFolder('')))
                startnew(DeleteFiles);
            mapSpeeds.ClearPB();
            UI::ShowNotification("Cleared pb speeds for all maps", 5000);
        }

        UI::Separator();

        if (mapSpeeds is null) {
            UI::TextWrapped("No map speeds loaded.");
            return;
        }

        UI::TextWrapped("Map UID: " + mapSpeeds.mapId);
        DrawSpeedRecDebug("currentSpeeds", mapSpeeds.currentSpeeds);
        DrawSpeedRecDebug("sessionBest", mapSpeeds.sessionBest);
        DrawSpeedRecDebug("bestSpeeds", mapSpeeds.bestSpeeds);
    }

    void DrawSpeedRecDebug(const string &in name, SpeedRecording@ sr) {
        UI::Text(name + ": ");
        UI::SameLine();
        if (sr !is null) {
            sr.DrawDebugInfo();
        } else {
            UI::Text("null");
        }
    }

    void DeleteFiles() {
        string folder = IO::FromStorageFolder('');
        auto files = IO::IndexFolder(folder, true);
        for(uint i = 0; i < files.Length; i++){
            IO::Delete(files[i]);
            if(i % 50 == 0)
                sleep(10);
        }
        print("Deleted all SplitSpeeds files");
    }
}
