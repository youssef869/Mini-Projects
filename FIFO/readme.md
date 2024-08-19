# Introduction
Implementing a FIFO (First-In-First-Out) memory. FIFO is memory structure that stores and retrieves
data elements in the order they were added. The FIFO memory will be designed to have two main
operations: writing (enqueuing) data and reading (dequeuing) data. We'll use two internal pointers
(counters) to keep track of the write and read positions within the memory. The write pointer advances
when new data is written, and the read pointer advances when data is read.

![image](https://github.com/user-attachments/assets/c2070e6b-7c9b-4bc7-bf42-c8d6f14a557d)


![image](https://github.com/user-attachments/assets/27cbc1c6-3ab0-4e1a-ba18-5d94d9d38213)


# Implementation details

### **Parameters**
-FIFO_WIDTH: word size inside the FIFO
-FIFO_DEPTH: number of words in the FIFO

### **Ports**

- **din_a**:  The input data bus used when writing the FIFO.
- **wen_a**:  If the FIFO is not full, asserting this signal causes
        data (on din_a) to be written into the FIFO
- **ren_b**:  If the FIFO is not empty, asserting this signal causes
        data (on dout_b) to be read from the FIFO
- **clk_a**:  Clock signal for port a, used in the writing operation
- **clk_b**:  Clock signal for port b, used in the reading operation
- **rst**:    Active high synchronous reset. It resets the dout_b, internal
        write counter & internal read counters
- **dout_b**: The output data bus used when reading from the FIFO.
- **full**:   When asserted, this signal indicates that the FIFO is
        full. Write requests are ignored when the FIFO is full, initiating a
        write when the FIFO is full is not destructive to the contents of the FIFO.
- **empty**:  When asserted, this signal indicates that the FIFO is
        empty. Read requests are ignored when the FIFO is empty,
        initiating a read while empty is not destructive to the FIFO.
