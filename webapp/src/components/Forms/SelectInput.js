import React from 'react'
import "./Forms.css"

function SelectInput({type,id,options,placeholder,setValue,multiple}) {
  return (
    <select multiple={multiple} onChange={(e)=>setValue(e.target.value)} placeholder={placeholder} className="select-input" type={type} id={id}>
      {placeholder && <option value="" disabled selected hidden>{placeholder}</option>}
            {options.map((option,i)=>(
                <option key={i}>{option.name}</option>
            ))}
       
    </select>
  ) 
}

export default SelectInput