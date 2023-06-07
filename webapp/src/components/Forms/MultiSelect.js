import React, { useState } from "react";

const MultiSelectDropdown = ({ options, placeholder,isOpen,setIsOpen }) => {
  const [selectedOptions, setSelectedOptions] = useState([]);
  const [searchTerm, setSearchTerm] = useState("");

  const handleOptionClick = (optionValue) => {
    if (selectedOptions.includes(optionValue)) {
      setSelectedOptions(selectedOptions.filter((option) => option !== optionValue));
    } else {
      setSelectedOptions([...selectedOptions, optionValue]);
    }
  };

  const toggleDropdown = () => {
    setIsOpen(!isOpen);
  };

  const handleSearchChange = (event) => {
    setSearchTerm(event.target.value);
  };

  const filteredOptions = options.filter((option) =>
    option.props.children.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="multi-select-dropdown">
      <div className="dropdown-header" onClick={toggleDropdown}>
        <div className="selected-options">
          {selectedOptions.length > 0 ? (
            selectedOptions.map((optionValue) => {
              const selectedOption = options.find((option) => option.props.value === optionValue);
              return (
                <span key={optionValue} className="selected-option">
                  {selectedOption && selectedOption.props.children}
                </span>
              );
            })
          ) : (
            <span className="placeholder">{placeholder}</span>
          )}
        </div>
        <div className={`dropdown-arrow ${isOpen ? "open" : ""}`}></div>
      </div>
      {isOpen && (
        <div>
          <input
            type="text"
            className="dropdown-search"
            placeholder="Search..."
            value={searchTerm}
            onChange={handleSearchChange}
          />
          <ul className="dropdown-options">
            {filteredOptions.map((option) => (
              <li
                key={option.props.value}
                className={`option ${selectedOptions.includes(option.props.value) ? "selected" : ""}`}
                onClick={() => handleOptionClick(option.props.value)}
              >
                {option.props.children}
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
};

export default MultiSelectDropdown;
