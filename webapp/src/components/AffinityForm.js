import React,{useState} from "react";
import "./Forms/Forms.css";
import TextInput from "./Forms/TextInput";
import InfoIcon from "../assets/infoIcon";
import SelectInput from "./Forms/SelectInput";
import TextAreaInput from "./Forms/TextAreaInput";
import PrimaryButton from "./Buttons/PrimaryButton";
import AffinityKeyInput from "./AffinityKeyInput";

function AffinityForm({ id }) {
  const [affinityKey, setAffinityKey] = React.useState("");

  const [list,setList] = useState([
    {
      id: 450,
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
  ])
  const referrals = [{ id: 0, name: "Member Intro Template" }];

  const offers = [{ id: 0, name: "Select..." }];

  const listTypes = [{ id: 0, name: "Manual Lists" }];

  const targets = [];

  const deals = [{ id: 0, name: "Deals" }];

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
            <SelectInput type="select" id="name" options={list} />
          </div>
        )}

        <div className="form-row">
          <label htmlFor="listName">List Name:</label>
          <TextInput type={"text"} id={"name"} />
        </div>
        <div className="form-row">
          <label htmlFor="referralTemplate">
            Referral Template: <InfoIcon />{" "}
          </label>
          <SelectInput type="select" id="name" options={referrals} />
        </div>

        <div className="form-row">
          <label htmlFor="offerNotifications">
            Offer Notifications: <InfoIcon />{" "}
          </label>
          <SelectInput type="select" id="name" options={offers} />
        </div>

        <div className="form-row">
          <label htmlFor="offerNotifications">
            List Type: <InfoIcon />{" "}
          </label>
          <SelectInput type="select" id="name" options={listTypes} />
          <div className="gap"></div>
          <SelectInput type="select" id="name" options={deals} />
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
          />
        </div>

        <div className="form-row">
          <label htmlFor="listItems">List Items: </label>
          <TextAreaInput
            placeholder={"Paste company names, one company per line"}
            type="select"
            id="name"
            options={listTypes}
          />
        </div>
      </div>

      

      <div className="affinityForm__submitBtn">
        <PrimaryButton title={"Done"} />
      </div>
    </div>
  );
}

export default AffinityForm;
