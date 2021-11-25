class FormModel {

	String domain = '';
	String consumer_key = '';
	String consumer_secret = '';

	FormModel({
		this.domain = '',
		this.consumer_key = '',
		this.consumer_secret = '',
	});

	factory FormModel.fromRawData( String rawData ) {

		List<String> data = rawData.split("|"); 

		if ( data.length < 3 || data[0].isEmpty || data[1].isEmpty || data[2].isEmpty ) {
			throw Exception('Unexpected type for data');
		}

		return FormModel(
			domain: data[0],
			consumer_key: data[1],
			consumer_secret: data[2],
		);
	}

	bool get isEmpty => (
		domain.isEmpty &&
		consumer_key.isEmpty &&
		consumer_secret.isEmpty
	);

}