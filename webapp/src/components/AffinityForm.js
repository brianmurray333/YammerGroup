import React,{useState} from "react";
import "./Forms/Forms.css";
import TextInput from "./Forms/TextInput";
import InfoIcon from "../assets/infoIcon";
import SelectInput from "./Forms/SelectInput";
import TextAreaInput from "./Forms/TextAreaInput";
import PrimaryButton from "./Buttons/PrimaryButton";
import AffinityKeyInput from "./AffinityKeyInput";
import MultiSelectInput from "./Forms/MultiSelect";

function AffinityForm({ id }) {
  const [affinityKey, setAffinityKey] = React.useState("");
  const [listName,setListName] = React.useState("")
  const [referral,setReferral] = React.useState("")
  const [offer,setOffer] = React.useState("")
  const [listType,setListType] = React.useState("")
  const [deal,setDeal] = React.useState("")
  const [target,setTarget] = React.useState("")
  const [listItem,setListItem] =React.useState("")
  



  const [list,setList] = useState([
    {
      id: 250,
      type: 0,
      name: "My List of People",
      public: true,
      owner_id: 38706,
      list_size: 67,
    },
    {
      id: 383,
      type: 1,
      name: "My List of Organizations",
      public: true,
      owner_id: 38706,
      list_size: 50,
    },
    {
      id: 323,
      type: 1,
      name: "My List of Staff",
      public: true,
      owner_id: 38706,
      list_size: 50,
    },

    {
      id: 393,
      type: 1,
      name: "My List of Marketers",
      public: true,
      owner_id: 38706,
      list_size: 50,
    },

    {
      id: 403,
      type: 1,
      name: "My List of Houses",
      public: true,
      owner_id: 38706,
      list_size: 50,
    },

    {
      id: 503,
      type: 1,
      name: "My List of Offices",
      public: true,
      owner_id: 38706,
      list_size: 50,
    },

    {
      id: 513,
      type: 1,
      name: "My List of Addresses",
      public: true,
      owner_id: 38706,
      list_size: 50,
    },

    {
      id: 523,
      type: 1,
      name: "My List of Places",
      public: true,
      owner_id: 38706,
      list_size: 50,
    },
  ])
  const referrals = [{ id: 0, name: "Member Intro Template" },{ id: 1, name: "Auditor Intro Template" }, { id: 2, name: "Founder Intro Template" }];

  const offers = [{ id: 1, name: "Acquisition" },{ id: 2, name: "Investment" }];

  const listTypes = [{ id: 0, name: "Manual Lists" },{ id: 1, name: "Automated Lists" }];

  const targets = [{ id: 0, name: "Founders" },{ id: 1, name: "Investors" },{ id: 2, name: "Advisors" }];

  const deals = [{ id: 0, name: "Deals" },{ id: 1, name: "Investments" }];


  const downloadJson = () =>{
    const jsonData = {
      listName:listName,
      referral:referral,
      offer:offer,
      listType:listType,
      deal:deal,
      target:target,
      listItem:listItem
    }

    const jsonString = JSON.stringify(jsonData);
    const blob = new Blob([jsonString], { type: 'application/json' });
    const url = URL.createObjectURL(blob);
    
    const link = document.createElement('a');
    link.href = url;
    link.download = 'data.json';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  }


  
  
  // Format options as an array of React elements
  const options = list.map((option) => (
    <option key={option.id} value={option.id}>
      {option.name}
    </option>
  ));
  
  const placeholder = 'Select list to add';

  return (
    <div id={id} className="affinityForm">
      <div className="form">
        <div className="form-row">
          <label htmlFor="listName">Affinity API key: </label>
          <AffinityKeyInput setAffinityKey={setAffinityKey} setList={setList}/>
        </div>

        {affinityKey && (
          <div className="form-row">
            <label htmlFor="listName">Select Lists to Add:</label>
            <MultiSelectInput options={options} placeholder={placeholder}/>
          </div>
        )}

        <div className="form-row">
          <label htmlFor="listName">List Name:</label>
          <TextInput setValue={setListName} type={"text"} id={"name"} />
        </div>
        <div className="form-row">
          <label htmlFor="referralTemplate">
            Referral Template: <InfoIcon />{" "}
          </label>
          <SelectInput setValue={setReferral} type="select" id="name" options={referrals} />
        </div>

        <div className="form-row">
          <label htmlFor="offerNotifications">
            Offer Notifications: <InfoIcon />{" "}
          </label>
          <SelectInput placeholder={"Select..."} setValue={setOffer} type="select" id="name" options={offers} />
        </div>

        <div className="form-row">
          <label htmlFor="offerNotifications">
            List Type: <InfoIcon />{" "}
          </label>
          <SelectInput setValue={setListType} type="select" id="name" options={listTypes} />
          <div className="gap"></div>
          <SelectInput setValue={setDeal} type="select" id="name" options={deals} />
        </div>

        <div className="form-row">
          <label htmlFor="offerNotifications">
            Target Personas: <InfoIcon />{" "}
          </label>
          <SelectInput
            placeholder={"Add target personas like founder,advisor etc"}
            type="select"
            id="name"
            options={targets}
            setValue={setTarget}
          />
        </div>

        <div className="form-row">
          <label htmlFor="listItems">List Items: </label>
          <TextAreaInput
            placeholder={"Paste company names, one company per line"}
            type="select"
            id="name"
            options={listTypes}
            setValue={setListItem}
          />
        </div>
      </div>

      

      <div className="affinityForm__submitBtn">
        <PrimaryButton onClick={downloadJson} title={"Done"} />
      </div>
    </div>
  );
}

export default AffinityForm;
