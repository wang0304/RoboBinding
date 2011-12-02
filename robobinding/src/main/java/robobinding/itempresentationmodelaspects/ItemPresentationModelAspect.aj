/**
 * Copyright 2011 Cheng Wei, Robert Taylor
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions
 * and limitations under the License.
 */
package robobinding.itempresentationmodelaspects;

import org.aspectj.lang.annotation.AdviceName;

import robobinding.itempresentationmodel.ItemPresentationModel;
import robobinding.presentationmodelaspects.PresentationModelMixin;
import robobinding.property.ObservableProperties;
/**
 * 
 * @since 1.0
 * @version $Revision: 1.0 $
 * @author Robert Taylor
 * @author Cheng Wei
 */
public aspect ItemPresentationModelAspect
{
	declare parents: !(ObservableProperties+) && ItemPresentationModel+ && !ItemPresentationModel implements PresentationModelMixin;

	pointcut updateData(PresentationModelMixin itemPresentationModel) : execution (* ItemPresentationModel+.updateData(int,*)) && this(itemPresentationModel) && within(PresentationModelMixin+);
	
	@AdviceName("fireItemPresentationModelRefresh")
	after(PresentationModelMixin itemPresentationModel) : updateData(itemPresentationModel)
	{
		itemPresentationModel.refreshPresentationModel();
	}

}