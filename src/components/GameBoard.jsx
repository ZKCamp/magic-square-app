import React, { useState } from 'react';

function GameBoard() {
    const [gridValues, setGridValues] = useState([
        ['', '', ''],
        ['', 12, ''],
        ['', '', ''],
    ]);

    const handleInputChange = (row, col, event) => {
        const newGridValues = [...gridValues];
        newGridValues[row][col] = event.target.value;
        setGridValues(newGridValues);
    };

    return (
        <div>
            <h2>Magic Square</h2>
            <table>
                <tbody>
                    {gridValues.map((row, rowIndex) => (
                        <tr key={rowIndex}>
                            {row.map((value, colIndex) => (
                                <td key={colIndex}>
                                    <input
                                        type="number"
                                        value={value}
                                        onChange={(event) => handleInputChange(rowIndex, colIndex, event)}
                                        readOnly={rowIndex == 1 && colIndex == 1}
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
