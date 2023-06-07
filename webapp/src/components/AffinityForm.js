import React, { useState } from "react";
import "./Forms/Forms.css";
import TextInput from "./Forms/TextInput";
import InfoIcon from "../assets/infoIcon";
import SelectInput from "./Forms/SelectInput";
import TextAreaInput from "./Forms/TextAreaInput";
import PrimaryButton from "./Buttons/PrimaryButton";
import AffinityKeyInput from "./AffinityKeyInput";
import MultiSelectInput from "./Forms/MultiSelect";
import lists from "../data/lists.json";

function AffinityForm({ id }) {
  const [affinityKey, setAffinityKey] = useState("");
  const [listName, setListName] = useState("");
  const [referral, setReferral] = useState("");
  const [offer, setOffer] = useState("");
  const [listType, setListType] = useState("");
  const [deal, setDeal] = useState("");
  const [target, setTarget] = useState("");
  const [listItem, setListItem] = useState("");
  const [list, setList] = useState(lists);

  //state of the dropdown
  const [isOpen,setIsOpen] = useState(false)

  const referrals = [
    { id: 0, name: "Member Intro Template" },
    { id: 1, name: "Auditor Intro Template" },
    { id: 2, name: "Founder Intro Template" },
  ];

  const offers = [
    { id: 1, name: "Acquisition" },
    { id: 2, name: "Investment" },
  ];

  const listTypes = [
    { id: 0, name: "Manual Lists" },
    { id: 1, name: "Automated Lists" },
  ];

  const targets = [
    { id: 0, name: "Founders" },
    { id: 1, name: "Investors" },
    { id: 2, name: "Advisors" },
  ];

  const deals = [
    { id: 0, name: "Deals" },
    { id: 1, name: "Investments" },
  ];

  const downloadJson = () => {
    const jsonData = {
      listName: listName,
      referral: referral,
      offer: offer,
      listType: listType,
      deal: deal,
      target: target,
      listItem: listItem,
    };

    const jsonString = JSON.stringify(jsonData);
    const blob = new Blob([jsonString], { type: "application/json" });
    const url = URL.createObjectURL(blob);

    const link = document.createElement("a");
    link.href = url;
    link.download = "affinity.json";
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  // Format options as an array of React elements
  const options = list.map((option) => (
    <option key={option.id} value={option.id}>
      {option.name}
    </option>
  ));

  const placeholder = "Select list to add";

  return (
    <div id={id} className="affinityForm">
      <div className="form">
        <div className="form-row">
          <label htmlFor="listName">Affinity API key: </label>
          <AffinityKeyInput setAffinityKey={setAffinityKey} setList={setList} />
        </div>

        {affinityKey && (
          <div className="form-row">
            <label onClick={()=>setIsOpen(!isOpen)} htmlFor="listName">Select Lists to Add:</label>
            <MultiSelectInput isOpen={isOpen} setIsOpen={setIsOpen} options={options} placeholder={placeholder} />
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
          <SelectInput
            setValue={setReferral}
            type="select"
            id="name"
            options={referrals}
          />
        </div>

        <div className="form-row">
          <label htmlFor="offerNotifications">
            Offer Notifications: <InfoIcon />{" "}
          </label>
          <SelectInput
            placeholder={"Select..."}
            setValue={setOffer}
            type="select"
            id="name"
            options={offers}
          />
        </div>

        <div  className="form-row">
          <label htmlFor="offerNotifications">
            List Type: <InfoIcon />{" "}
          </label>
          <SelectInput
            setValue={setListType}
            type="select"
            id="name"
            options={listTypes}
          />
          <div className="gap"></div>
          <SelectInput
            setValue={setDeal}
            type="select"
            id="name"
            options={deals}
          />
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
