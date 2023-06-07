import React,{useState,useEffect} from "react";
import TextInput from "./Forms/TextInput";
import PrimaryButton from "./Buttons/PrimaryButton";
import "./Affinity.css";
import axios from "axios"

function AffinityKeyInput({ setAffinityKey,setList}) {
  const [apiKey, setApiKey] = useState("");
  const [disabled, setDisabled] = useState(true);

  useEffect(() => {
    if (apiKey.length > 3) {
      setDisabled(false);
    }
    else{
      setDisabled(true)
    }
  }, [apiKey]);

  const saveAPIKey = () => {
    //save the api key in session storage
    sessionStorage.setItem("affinityAPIkey", apiKey);

    // call API to fetch the lists
    axios.get(process.env.REACT_APP_API_URL+"/list",
    {
      auth:{
        password:apiKey
      }
    }
    ).then((response)=>{
      console.log(response)
      //set the list with the data from the endpoint
      // setList(response.data)
    }).catch((error)=>{
      console.log(error)
    })
    setDisabled(true)
    setAffinityKey(apiKey)
  };

  return (
    <div className="affinityInput">
      <div className="affinityApiForm">
        <TextInput
          setValue={(e) => setApiKey(e)}
          width={"300px"}
          type={"text"}
          id={"apikey"}
        />
        <div className="gap"></div>
        {apiKey.length > 0 && <PrimaryButton
          disabled={disabled}
          onClick={saveAPIKey}
          title={"Save"}
        />}
        </div>

      <div className="info">
       Obtain your Affinity API key{" "}
        <a
          href="https://support.affinity.co/hc/en-us/articles/360032633992-How-to-obtain-your-API-Key"
          target="_blank"
          rel="noreferrer"
        >
          here
        </a>
      </div>
    </div>
  );
}

export default AffinityKeyInput;
