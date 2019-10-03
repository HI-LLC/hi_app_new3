import React, {Component} from 'react';
import {Platform, StyleSheet, TextInput, Text, View} from 'react-native';
import { TouchableOpacity, ActivityIndicator,Alert} from 'react-native';
type Props = {};
export default class HiDataGrid extends Component<Props> {

	state = {
		row: [
			{col:[
				{value:'',dataMode:''},
				{value:'',dataMode:''},
				{value:'',dataMode:''},
			]},
			{col:[
				{value:'',dataMode:''},
				{value:'',dataMode:''},
				{value:'',dataMode:''},
			]},
			{col:[
				{value:'',dataMode:''},
				{value:'',dataMode:''},
				{value:'',dataMode:''},
			]},
			{col:[
				{value:'',dataMode:''},
				{value:'',dataMode:''},
				{value:'',dataMode:''},
			]},
			{col:[
				{value:'',dataMode:''},
				{value:'',dataMode:''},
				{value:'',dataMode:''},
			]},
			{col:[
				{value:'',dataMode:''},
				{value:'',dataMode:''},
				{value:'',dataMode:''},
			]},
			{col:[
				{value:'',dataMode:''},
				{value:'',dataMode:''},
				{value:'',dataMode:''},
			]},
			{col:[
				{value:'',dataMode:''},
				{value:'',dataMode:''},
				{value:'',dataMode:''},
			]},
			{col:[
				{value:'',dataMode:''},
				{value:'',dataMode:''},
				{value:'',dataMode:''},
			]},
			{col:[
				{value:'',dataMode:''},
				{value:'',dataMode:''},
				{value:'',dataMode:''},
			]},
			{col:[
				{value:'',dataMode:''},
				{value:'',dataMode:''},
				{value:'',dataMode:''},
			]},
			{col:[
				{value:'',dataMode:''},
				{value:'',dataMode:''},
				{value:'',dataMode:''},
			]},
			]
		}
	_makeUpdateDataString(r,c) {
		let key_col = [0,1];
		let update_string = '[
		for(let i=0;i<key_col.length;i++) {
			update_string = update_string + '{"r":" + r.toString() + '","c":"' + key_col[i].toString() + '","v":" + this.state.row[r].col[key_col[i]].value + '"},';
		}
		update_string = update_string + '{"r":"' + r.toString() + '","c":"' + c.toString();update_string = update_string + '","v":"' + this.state.row[r].col[c].value + '"}]';
		return update_string;
	}
        onChangeTextHandler = async (text,r,c) => {
            let statusCopy = Object.assign({}, this.state);
            statusCopy.row[r].col[c].value = text;
            this.setState(statusCopy);
        }


        onBlurTextHandler = (r,c) => {
            this._makeUpdateDataString(r,c);
            let data_string = this._makeUpdateDataString(r,c);
            let update_input_string = '{"usp_name":"usp_000111_gui_rn_update","input_data":' + data_string + '}';
            this._upDateData(update_input_string);
        }

       async _upDateData(update_input_string) {
            fetch('https://dev.healthinteractiveinc.com/api/ReactNative/usp_000111_gui_rn_pass_through', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(
                {
                    "user_id": 0,
					"transaction_token":"asldkdfkjoiwidd29883@3@#Gadf09EDAw0esdf",
					"gui_id":12,
                    "input": update_input_string
                })
            })
            .then((response) => response.json())
            .then((responseJson) => {
                let output = responseJson.output;
            })
            .catch((error) => {
                console.error(error);
            });
        }   
        retrieveHandlePress = async () => {
			fetch('https://dev.healthinteractiveinc.com/api/ReactNative/usp_000111_gui_rn_pass_through', {
                method: 'POST',
				headers: {
					'Content-Type': 'application/json',
				},
				body: JSON.stringify(
				{
					"user_id": 0,
					"transaction_token":"asldkdfkjoiwidd29883@3@#Gadf09EDAw0esdf",
					"gui_id":12,
					"input": '{"usp_name":"usp_000111_gui_rn_detail_retrieve","input_data":["0"]}'
				})
			})
			.then((response) => response.json())
			.then((responseJson) => {
				let statusCopy = Object.assign({}, this.state)
				let the_data = JSON.parse(responseJson.output)
				for(let i=0;i<the_data.length;i++) {
					statusCopy.row[the_data[i].r].col[the_data[i].c].value = the_data[i].v; 
				}           
	//          statusCopy.row = the_data.row
				this.setState(statusCopy);
			})
			.catch((error) => {
				console.error(error);
			});
	   }
	render() {
		return (
			<View style={styles.table_container}>
				<View style={styles.row_container}>
					<View style={styles.cell_container}>
					</View>
					<View style={styles.cell_container}>
					</View>
					<View style={styles.cell_container}>
						<TouchableOpacity
						style={styles.button_text}
						onPress={this.retrieveHandlePress.bind(this)}
						>
							<Text
							style={styles.button_text}
							/>
						</TouchableOpacity>
					</View>
				</View>
				<View style={styles.row_container}>
					<View style={styles.cell_container}>
						<Text>
							ID
						</Text>
					</View>
					<View style={styles.cell_container}>
						<Text>
							Last Name
						</Text>
					</View>
					<View style={styles.cell_container}>
						<Text>
							First Name
						</Text>
					</View>
				</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[0].col[0].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[0].col[1].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<TextInput
							value={this.state.row[0].col[2].value}
							onChangeText={(text) => { this.onChangeTextHandler(text,0,2)}}
							onBlur={() => { this.onBlurTextHandler(0,2)}}
						/>
					</View>
				</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[1].col[0].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[1].col[1].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<TextInput
							value={this.state.row[1].col[2].value}
							onChangeText={(text) => { this.onChangeTextHandler(text,1,2)}}
							onBlur={() => { this.onBlurTextHandler(1,2)}}
						/>
					</View>
				</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[2].col[0].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[2].col[1].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<TextInput
							value={this.state.row[2].col[2].value}
							onChangeText={(text) => { this.onChangeTextHandler(text,2,2)}}
							onBlur={() => { this.onBlurTextHandler(2,2)}}
						/>
					</View>
				</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[3].col[0].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[3].col[1].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<TextInput
							value={this.state.row[3].col[2].value}
							onChangeText={(text) => { this.onChangeTextHandler(text,3,2)}}
							onBlur={() => { this.onBlurTextHandler(3,2)}}
						/>
					</View>
				</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[4].col[0].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[4].col[1].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<TextInput
							value={this.state.row[4].col[2].value}
							onChangeText={(text) => { this.onChangeTextHandler(text,4,2)}}
							onBlur={() => { this.onBlurTextHandler(4,2)}}
						/>
					</View>
				</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[5].col[0].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[5].col[1].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<TextInput
							value={this.state.row[5].col[2].value}
							onChangeText={(text) => { this.onChangeTextHandler(text,5,2)}}
							onBlur={() => { this.onBlurTextHandler(5,2)}}
						/>
					</View>
				</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[6].col[0].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[6].col[1].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<TextInput
							value={this.state.row[6].col[2].value}
							onChangeText={(text) => { this.onChangeTextHandler(text,6,2)}}
							onBlur={() => { this.onBlurTextHandler(6,2)}}
						/>
					</View>
				</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[7].col[0].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[7].col[1].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<TextInput
							value={this.state.row[7].col[2].value}
							onChangeText={(text) => { this.onChangeTextHandler(text,7,2)}}
							onBlur={() => { this.onBlurTextHandler(7,2)}}
						/>
					</View>
				</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[8].col[0].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[8].col[1].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<TextInput
							value={this.state.row[8].col[2].value}
							onChangeText={(text) => { this.onChangeTextHandler(text,8,2)}}
							onBlur={() => { this.onBlurTextHandler(8,2)}}
						/>
					</View>
				</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[9].col[0].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<Text style={styles.}>
							{this.state.row[9].col[1].value}
						</Text>
					</View>
					<View style={styles.cell_container}>
						<TextInput
							value={this.state.row[9].col[2].value}
							onChangeText={(text) => { this.onChangeTextHandler(text,9,2)}}
							onBlur={() => { this.onBlurTextHandler(9,2)}}
						/>
					</View>
				</View>
			</View>
		);
	}
}

const styles = StyleSheet.create({
	table_container: {
		alignItems:'center',
		flex:1,
		justifyContent:'center',
		backgroundColor:'#F5FCFF',
	},
	row_container: {
		alignItems:'center',
		flex:1,
		flexDirection:'row',
		justifyContent:'center',
		backgroundColor:'#F5FCFF',
	},
	col_container: {
		alignItems:'center',
		flex:1,
		flexDirection:'column',
		justifyContent:'center',
		backgroundColor:'#F5FCFF',
	},
	cell_container: {
		alignItems:'center',
		flex:1,
		justifyContent:'center',
		backgroundColor:'#F5FCFF',
	},
});
