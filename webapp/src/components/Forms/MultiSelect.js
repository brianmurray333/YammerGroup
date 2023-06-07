import React, { useState } from "react";

const MultiSelectDropdown = ({ options, placeholder }) => {
  const [selectedOptions, setSelectedOptions] = useState([]);
  const [isOpen, setIsOpen] = useState(false);

  const handleOptionClick = (optionValue) => {
    if (selectedOptions.includes(optionValue)) {
      setSelectedOptions(
        selectedOptions.filter((option) => option !== optionValue)
      );
    } else {
      setSelectedOptions([...selectedOptions, optionValue]);
    }
  };

  const toggleDropdown = () => {
    setIsOpen(!isOpen);
  };

  return (
    <div className="multi-select-dropdown">
      <div className="dropdown-header" onClick={toggleDropdown}>
        <div className="selected-options">
          {selectedOptions.length > 0 ? (
            selectedOptions.map((option) => (
              <span key={option} className="selected-option">
                {option}
              </span>
            ))
          ) : (
            <span className="placeholder">{placeholder}</span>
          )}
        </div>
        <div className={`dropdown-arrow ${isOpen ? "open" : ""}`}></div>
      </div>
      {isOpen && (
        <ul className="dropdown-options">
          {options.map((option) => (
            <li
              key={option}
              className={`option ${
                selectedOptions.includes(option) ? "selected" : ""
              }`}
              onClick={() => handleOptionClick(option)}
            >
              {option}
            </li>
          ))}
        </ul>
      )}
    </div>
  );
};

export default MultiSelectDropdown;
