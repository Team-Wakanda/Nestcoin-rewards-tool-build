import React from "react";
import {Home, Footer, Navbar} from '././components';

function App() {
  return (
    <div className="App">
      <div>
        <Navbar />
      </div>
     
      <div>
        <Home />
        <Footer />
      </div>
    </div>
  );
}

export default App;
