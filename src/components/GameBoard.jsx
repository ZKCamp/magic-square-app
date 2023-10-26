import React, { useState } from 'react';

function GameBoard(props) {
    // const [gridValues, setGridValues] = useState([
    //     ['', '', ''],
    //     ['', '', ''],
    //     ['', '', ''],
    // ]);

    const handleInputChange = (row, col, event) => {
        const newGridValues = [...props.gridValues];
        newGridValues[row][col] = event.target.value;
        props.setGridValues(newGridValues);
    };

    return (
        <div>
            <table>
                <tbody>
                    {props.gridValues.map((row, rowIndex) => (
                        <tr key={rowIndex}>
                            {row.map((value, colIndex) => (
                                <td key={colIndex}>
                                    <input
                                        type="number"
                                        value={value}
                                        onChange={(event) => handleInputChange(rowIndex, colIndex, event)}
                                        // readOnly={rowIndex == 1 && colIndex == 1}
                                    />
                                </td>
                            ))}
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}

export default GameBoard;
