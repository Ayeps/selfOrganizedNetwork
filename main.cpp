#include "Signal.h"
#include <iostream>
#include <thread>
#include <chrono>
#include <vector>
#include <sys/prctl.h>
#include <memory>

#include "manager.h"
#include "mmwavebs.h"
#include "idgenerator.h"
#include "painter.h"

int main() {
    
  IDGenerator* _idGenerator = IDGenerator::instance();
  std::shared_ptr<Painter> _painter = std::make_shared<Painter>();
  Manager manager(_painter);
  _painter.get()->Start();
  
  for(int i =1;i<16;i++)
  {
	mmWaveBS* BS = new mmWaveBS(3.0*i , 3.0*i, _idGenerator->next());
	manager.m_vector_BSs.push_back(BS);
	BS->Start();
	BS->candidacy.connect_member(&manager, &Manager::listen_For_Candidacy);
	BS->clusterHead.connect_member(&manager, &Manager::listen_For_ClusterHead);
	BS->conflict.connect_member(&manager, &Manager::listen_For_Conflict);
  }
  
  	mmWaveBS* BS = new mmWaveBS(0.0 , 0.0, _idGenerator->next());
	BS->setClusterID(BS->getID());
	BS->setStatus(Status::clusterHead);
	manager.m_vector_BSs.push_back(BS);
	BS->Start();
	BS->candidacy.connect_member(&manager, &Manager::listen_For_Candidacy);
	BS->clusterHead.connect_member(&manager, &Manager::listen_For_ClusterHead);
	BS->conflict.connect_member(&manager, &Manager::listen_For_Conflict);
	
	
	while(1)
	{
		true;
	}
  return 0;
}
